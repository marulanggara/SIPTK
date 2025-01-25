const express   = require('express');
const cookieParser = require('cookie-parser');
const db        = require('./config/database');
const cors      = require('cors');
const jwt       = require('jsonwebtoken');
const bcrypt    = require('bcryptjs');
const bodyParser= require('body-parser');
const multer    = require('multer');
const xlsx      = require('xlsx');
const path      = require('path');
const helmet    = require('helmet')
const crypto    = require('crypto');

require('dotenv').config();

const app   = express();
const PORT = process.env.PORT;
const jwtSecret = process.env.JWT_SECRET;

// app.use(cors());

app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT','PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.use(express.json());
app.use(bodyParser.json());
app.use(cookieParser());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// Middleware to generate a nonce for each request
// app.use((req, res, next) => {
//     res.locals.nonce = crypto.randomBytes(16).toString('hex');
//     next();
// });

// app.use(
//   helmet({
//     contentSecurityPolicy: {
//       useDefaults: true,
//       directives: {
//         defaultSrc: ["'self'"],
//         // pastikan tidak terjadi kerentanan unsafe-inline
//         scriptSrc: ["'self'", "https://code.jquery.com", "https://cdnjs.cloudflare.com", "https://www.google-analytics.com", "https://www.gstatic.com"],
//         styleSrc: ["'self'", "https://fonts.googleapis.com"],
//         imgSrc: ["'self'", "data:"],
//         fontSrc: ["'self'", "https://fonts.gstatic.com"],
//         connectSrc: ["'self'", "ws://localhost:4000"],
//         frameAncestors: ["'self'"],
//         objectSrc: ["'none'"], // Prevents loading any plugins like Flash
//         upgradeInsecureRequests: [], // Forces all requests to use HTTPS
//       },
//     },
//   })
// );


// get /
app.get('/', (req, res) => {
    res.send('Hello World!');
});

// app.post("/report-violation", (req, res) => {
//   // Simpan laporan pelanggaran ke dalam log atau database
//   console.log("CSP violation:", req.body);
//   res.status(204).send();
// });

const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ message: 'Token not provided' });
    }

    jwt.verify(token, jwtSecret, (err, user) => {
        if (err) {
            if (err.name === 'TokenExpiredError') {
                return res.status(401).json({ message: 'Token expired' });
            }
            return res.status(401).json({ message: 'Invalid token' });
        }

        req.user = user; // Pastikan user object disimpan di req.user
        next();
    });
};

const checkCredentials = async (table, usernameField, passwordField, username, password) => {
    try {
        const query = `SELECT * FROM ${table} WHERE ${usernameField} = ?`;
        const [rows] = await db.query(query, [username]);
    
        if (rows.length > 0 ) {
            const user = rows[0];
            // Check password hash and plain password
            const isPasswordValid = user[passwordField] && 
                                    (bcrypt.compareSync(password, user[passwordField]) || 
                                    password === user[passwordField]);
            return isPasswordValid;
        } else {
            return false;
        }
    } catch (error) {
        console.error('Error executing SQL query:', error);
        throw new Error('Database query error');
    }
};

// app.post('/login', async (req, res) => {
//     // console.log(req.body); // Check the data received
//     const { username, password } = req.body;

//     let table, usernameField, passwordField, nameField, idField;

//     try {
//         // Check mahasiswa table
//         let query = 'SELECT * FROM mahasiswa WHERE NimMaha = ?';
//         let [rows] = await db.query(query, [username]);

//         if (rows.length > 0) {
//             table = 'mahasiswa';
//             usernameField = 'NimMaha';
//             passwordField = 'passwordMaha';
//             nameField = 'NamaMaha';
//             idField = 'IdMaha';
//         } else {
//             // Check dosen table
//             query = 'SELECT * FROM dosen WHERE Nip = ?';
//             [rows] = await db.query(query, [username]);

//             if (rows.length > 0) {
//                 table = 'dosen';
//                 usernameField = 'Nip';
//                 passwordField = 'passwordDosen';
//                 nameField = 'NamaDosen';
//                 idField = 'IdDosen';
//             } else {
//                 // Check admin table
//                 query = 'SELECT * FROM admin WHERE usernameAdmin = ?';
//                 [rows] = await db.query(query, [username]);

//                 if (rows.length > 0) {
//                     table = 'admin';
//                     usernameField = 'usernameAdmin';
//                     passwordField = 'passwordAdmin';
//                     nameField = 'NamaAdmin';
//                     idField = 'IdAdmin';
//                 } else {
//                     // Check gpm table
//                     query = 'SELECT * FROM gpm WHERE Nip = ?';
//                     [rows] = await db.query(query, [username]);

//                     if (rows.length > 0) {
//                         table = 'gpm';
//                         usernameField = 'Nip';
//                         passwordField = 'passwordGpm';
//                         nameField = 'NamaGpm';
//                         idField = 'IdGpm';
//                     } else {
//                         return res.status(401).json({ message: 'Invalid username or password', success: false });
//                     }
//                 }
//             }
//         }

//         // Validate credentials
//         const isValid = await checkCredentials(table, usernameField, passwordField, username, password);

//         if (isValid) {
//             const query = `SELECT ${idField}, ${nameField} FROM ${table} WHERE ${usernameField} = ?`;
//             const [rows] = await db.query(query, [username]);
//             const user = rows[0];

//             // Generate JWT Token
//             const token = jwt.sign({ role: table, name: user[nameField], id: user[idField] }, jwtSecret, { expiresIn: '1h' });

//             res.json({ message: `${table} login successful`, success: true, token, role: table });
//         } else {
//             return res.status(401).json({ message: 'Invalid username or password', success: false });
//         }
//     } catch (error) {
//         console.error('Error during login:', error);
//         res.status(500).json({ message: 'Login error', success: false });
//     }
// });

app.post('/login', async (req, res) => {
    const { role, username, password } = req.body;

    let table, usernameField, passwordField, nameField, idField;

    switch (role) {
        case 'admin':
            table = 'admin';
            usernameField = 'usernameAdmin';
            passwordField = 'passwordAdmin';
            nameField = 'NamaAdmin';
            idField = 'IdAdmin';
            break;
        case 'dosen':
            table = 'dosen';
            usernameField = 'Nip';
            passwordField = 'passwordDosen';
            nameField = 'NamaDosen';
            idField = 'IdDosen';
            break;
        case 'mahasiswa':
            table = 'mahasiswa';
            usernameField = 'NimMaha';
            passwordField = 'passwordMaha';
            nameField = 'NamaMaha';
            idField = 'IdMaha';
            break;
        case 'gpm':
            table = 'gpm';
            usernameField = 'Nip';
            passwordField = 'passwordGpm';
            nameField = 'NamaGpm';
            idField = 'IdGpm';
            break;
        default:
            return res.status(400).json({ message: 'Invalid role' });
    }

    try {
        const isValid = await checkCredentials(table, usernameField, passwordField, username, password);
        if (isValid) {
            const query = `SELECT ${idField}, ${nameField} FROM ${table} WHERE ${usernameField} = ?`;
            const [rows] = await db.query(query, [username]);
            const user = rows[0];

            // Generate JWT Token
            const token = jwt.sign({ role, name: user[nameField], id: user[idField] }, jwtSecret, { expiresIn: '1h'});

            res.json({ message: `${role} login successful`, success: true, token });
        } else {
            return res.status(401).json({ message: 'Gagal Log In. Periksa kembali username dan password anda.', success: false });
        }
    } catch (error) {
        console.error('Error checking credential: ', error);
        res.status(500).json({ message: 'Login error' });
    }
});

app.get('/mahasiswa-profile', authenticateToken, async (req, res) => {
    const userId = req.user.id;

    try {
        const query = `SELECT * FROM mahasiswa WHERE IdMaha = ?`;
        const [rows] = await db.query(query, [userId]);

        if (rows.length > 0) {
            const mahasiswa = rows[0];
            res.status(200).json({ role: 'mahasiswa', name: mahasiswa.NamaMaha, nim: mahasiswa.NimMaha });
        } else {
            res.status(404).json({ message: 'Mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error fetching mahasiswa profile:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

app.get('/dosen-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;

    try {
        const query = `SELECT * FROM dosen WHERE IdDosen = ?`;
        const [rows] = await db.query(query, [userId]);

        if (rows.length > 0) {
            const dosen = rows[0];
            // Mengambil data Alamat dan PhoneDosen
            const { PhoneDosen } = dosen;
            res.status(200).json({ role: 'dosen', ...dosen });
        } else {
            res.status(404).json({ message: 'Dosen not found' });
        }
    } catch (error) {
        console.error('Error fetching dosen info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// Update dosen info
app.put('/dosen-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;
    const { PhoneDosen, Alamat, passwordDosen } = req.body;

    try {
        // Ambil password lama dari db
        const [rows] = await db.query(`SELECT passwordDosen FROM dosen WHERE IdDosen = ?`, [userId]);
        const currentPassword = rows[0]?.passwordDosen;

        let updateData = {PhoneDosen, Alamat };

        // Hanya hash dan update password baru
        if (passwordDosen && passwordDosen != currentPassword) {
            const hashedPassword = hashPassword(passwordDosen);
            updateData.passwordDosen = hashedPassword;
        }

        const query = `UPDATE dosen SET ? WHERE IdDosen = ?`;
        await db.query(query, [updateData, userId]);

        res.status(200).json({ message: 'Dosen info updated successfully' });
    } catch (error) {
        console.error('Error updating dosen info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});
    

// GET admin info
app.get('/admin-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;

    try {
        const query = `SELECT * FROM admin WHERE IdAdmin = ?`;
        const [rows] = await db.query(query, [userId]);

        if (rows.length > 0) {
            const admin = rows[0];
            res.status(200).json({ role: 'admin', name: admin.NamaAdmin});
        } else {
            res.status(404).json({ message: 'Admin not found' });
        }
    } catch (error) {
        console.error('Error fetching admin info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// GET GPM info
app.get('/gpm-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;

    try {
        const query = `SELECT * FROM gpm WHERE IdGpm = ?`;
        const [rows] = await db.query(query, [userId]);

        if (rows.length > 0) {
            const gpm = rows[0];
            res.status(200).json({ role: 'gpm', ...gpm });
        } else {
            res.status(404).json({ message: 'GPM not found' });
        }
    } catch (error) {
        console.error('Error fetching GPM info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

app.get('/mahasiswa-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;

    try {
        const query = `
            SELECT mahasiswa.*, dosen.NamaDosen
            FROM mahasiswa
            LEFT JOIN dosen ON mahasiswa.IdDosen = dosen.IdDosen
            WHERE mahasiswa.IdMaha = ?`;
        const [rows] = await db.query(query, [userId]);

        if (rows.length > 0) {
            const mhs = rows[0];
            res.status(200).json({ role: 'mahasiswa', ...mhs });
        } else {
            res.status(404).json({ message: 'Mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error fetching mahasiswa info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// Update mahasiswa yang sedang login pada profile ke dalam tabel mahasiswa dengan password terhash
app.put('/mahasiswa-info', authenticateToken, async (req, res) => {
    const userId = req.user.id;
    const {
        Alamat,
        phone,
        // Semester,
        passwordMaha,
        // is_surveyed
    } = req.body;

    try {
        // Ambil password lama dari db
        const [rows] = await db.query(`SELECT passwordMaha FROM mahasiswa WHERE IdMaha = ?`, [userId]);
        const currentPassword = rows[0]?.passwordMaha;

        let updateData = {phone, Alamat};

        // Hanya hash dan update password baru
        if (passwordMaha && passwordMaha != currentPassword) {
            const hashedPassword = hashPassword(passwordMaha);
            updateData.passwordMaha = hashedPassword;
        }

        const query = `UPDATE mahasiswa SET ? WHERE IdMaha = ?`;
        // const [rows] = await db.query(query, [{ Alamat, phone, Semester, passwordMaha: hashedPassword, is_surveyed }, userId]);
        await db.query(query, [updateData, userId]);

        res.status(200).json({ message: "Mahasiswa info data update successfully"});
    } catch (error) {
        console.error('Error updating mahasiswa info:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

const hashPassword = (password) => {
  const salt = bcrypt.genSaltSync(10);
  return bcrypt.hashSync(password, salt);
};

// GET all data mahasiswa untuk dosen
app.get('/mahasiswa', authenticateToken, async (req, res) => {
    try {
        const idDosen = req.user.id; // Ambil IdDosen dari user yang terautentikasi
        // Join dengan IdDosen NamaDosen pada tabel dosen
        const query = `
            SELECT mahasiswa.*, dosen.NamaDosen 
            FROM mahasiswa 
            JOIN dosen 
            ON mahasiswa.IdDosen = dosen.IdDosen 
            WHERE mahasiswa.IdDosen = ?`;
        const [rows] = await db.query(query, [idDosen]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Data mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error fetching data mahasiswa:', error);
        res.status(500).json({ message: 'Error fetching data mahasiswa' });
    }
}); 

// GET all mahasiswa yang hanya bisa diakses ketika user yang login yaitu admin atau gpm
app.get('/all/mahasiswa', authenticateToken, async (req, res) => {
    try {
        // ambil data mahasiswa dengan join NamaDosen dari tabel dosen
        const query = `
            SELECT mahasiswa.*, dosen.NamaDosen 
            FROM mahasiswa 
            LEFT JOIN dosen 
            ON mahasiswa.IdDosen = dosen.IdDosen`;
        const [rows] = await db.query(query);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Data mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error fetching data mahasiswa:', error);
        res.status(500).json({ message: 'Error fetching data mahasiswa' });
    }

});

// PUT mahasiswa berdasarkan IdMaha untuk update password
app.put('/update/mahasiswa/:IdMaha', authenticateToken, async (req, res) => {
    const IdMaha = req.params.IdMaha;
    const { NamaMaha, NimMaha, phone, Alamat, Ipk, Semester, passwordMaha} = req.body;

    if (!NamaMaha && !NimMaha && !phone && !Alamat && !Ipk && !Semester && !passwordMaha) {
        res.status(400).json({ message: 'Please provide at least one field to update' });
    }

    try {
        let updates = [];
        let value = [];

        if (NamaMaha) {
            updates.push('NamaMaha = ?');
            value.push(NamaMaha);
        }
        if (NimMaha) {
            updates.push('NimMaha = ?');
            value.push(NimMaha);
        }
        if (phone) {
            updates.push('phone = ?');
            value.push(phone);
        }
        if (Alamat) {
            updates.push('Alamat = ?');
            value.push(Alamat);
        }
        if (Ipk) {
            updates.push('Ipk = ?');
            value.push(Ipk);
        }
        if (Semester) {
            updates.push('Semester = ?');
            value.push(Semester);
            updates.push('is_surveyed = 0')
        }
        if (passwordMaha) {
            const hashedPassword = hashPassword(passwordMaha);
            updates.push('passwordMaha = ?');
            value.push(hashedPassword);
        }

        value.push(IdMaha);

        const query = `UPDATE mahasiswa SET ${updates.join(', ')} WHERE IdMaha = ?`;
        const [rows] = await db.query(query, value);

        if (rows.affectedRows > 0) {
            res.status(200).json({ message: 'Mahasiswa updated successfully' });
        } else {
            res.status(404).json({ message: 'Mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error updating mahasiswa:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// PUT mahasiswa berdasarkan IdMaha untuk update IdDosen pada tabel mahasiswa
app.put('/update/mahasiswa/pengampu/:IdMaha', authenticateToken, async (req, res) => {
    const IdMaha = req.params.IdMaha;
    const { IdDosen } = req.body;

    try {
        const query = 'UPDATE mahasiswa SET IdDosen = ? WHERE IdMaha = ?';
        const [result] = await db.query(query, [IdDosen, IdMaha]);
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'IdDosen updated successfully' });
        } else {
            res.status(404).json({ message: 'IdDosen not found' });
        }
    } catch (error) {
        console.error('Error updating IdDosen:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// DELETE mahasiswa berdasarkan id
app.delete('/delete/mahasiswa/:IdMaha', authenticateToken, async (req, res) => {
    const IdMaha = req.params.IdMaha;

    try {
        const query = 'DELETE FROM mahasiswa WHERE IdMaha = ?';
        const [result] = await db.query(query, [IdMaha]);

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Data mahasiswa deleted successfully' });
        } else {
            res.status(404).json({ message: 'Data mahasiswa not found' });
        }
    } catch (error) {
        console.error('Error deleting data mahasiswa:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// GET all data dosen
app.get('/dosen', authenticateToken, async (req, res) => {
    try {
        const query = `SELECT * FROM dosen`;
        const [rows] = await db.query(query);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Data dosen not found' });
        }
    } catch (error) {
        console.error('Error fetching data dosen:', error);
        res.status(500).json({ message: 'Error fetching data dosen' });
    }
});

// POST dosen untuk admin menambahkan dosen baru ke database
app.post('/add-dosen', authenticateToken, async (req, res) => {
    const { 
        NamaDosen, 
        Nip, 
        PhoneDosen, 
        Alamat
    } = req.body;

    try {
        const hashedPassword = bcrypt.hashSync("dosen123", 10);
        const query = 'INSERT INTO dosen (NamaDosen, Nip, passwordDosen, PhoneDosen, Alamat) VALUES ( ?, ?, ?, ?, ?)';
        const [result] = await db.query(query, [NamaDosen, Nip, hashedPassword, PhoneDosen, Alamat ]);
        if (result.affectedRows > 0) {
            res.status(201).json({ message: 'Dosen added successfully' });
        } else {
            res.status(500).json({ message: 'Failed to add dosen' });
        }
    } catch (error) {
        console.error('Error adding dosen:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// PUT untuk update password dosen
app.put('/update/dosen/:IdDosen', authenticateToken, async (req, res) => {
    const IdDosen = req.params.IdDosen;
    const { NamaDosen, Nip, PhoneDosen, Alamat, password } = req.body;

    if (!NamaDosen && !Nip && !PhoneDosen && !Alamat && !password ) {
        return res.status(400).json({ message: 'Tidak ada data yang diupdate' });
    }

    try {
        let updates = [];
        let value = [];
        
        if (NamaDosen) {
            updates.push('NamaDosen = ?');
            value.push(NamaDosen);
        }
        if (Nip) {
            updates.push('Nip = ?');
            value.push(Nip);
        }
        if (PhoneDosen) {
            updates.push('PhoneDosen = ?');
            value.push(PhoneDosen);
        }
        if (Alamat) {
            updates.push('Alamat = ?');
            value.push(Alamat);
        }
        if (password) {
            const hashedPassword = hashPassword(password);
            updates.push('passwordDosen = ?');
            value.push(hashedPassword);
        }

        if (updates.length === 0) {
            return res.status(400).json({ message: 'Tidak ada data yang diupdate' });
        }

        value.push(IdDosen);

        const query = `UPDATE dosen SET ${updates.join(', ')} WHERE IdDosen = ?`;
        const [result] = await db.query(query, value);

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Dosen updated successfully' });
        } else {
            res.status(404).json({ message: 'Dosen not found' });
        }
    } catch (error) {
        console.error('Error updating dosen:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// DELETE untuk hapus dosen
app.delete('/delete/dosen/:IdDosen', authenticateToken, async (req, res) => {
    const IdDosen = req.params.IdDosen;

    try {
        const query = 'DELETE FROM dosen WHERE IdDosen = ?';
        const [result] = await db.query(query, [IdDosen]);
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Dosen deleted successfully' });
        } else {
            res.status(404).json({ message: 'Dosen not found' });
        }
    } catch (error) {
        console.error('Error deleting dosen:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// GET all data GPM
app.get('/gpm', authenticateToken, async (req, res) => {
    try {
        const query = `SELECT * FROM gpm`;
        const [rows] = await db.query(query);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Data GPM not found' });
        }
    } catch (error) {
        console.error('Error fetching data GPM:', error);
        res.status(500).json({ message: 'Error fetching data GPM' });
    }
});

// POST gpm untuk add data baru gpm
app.post('/add-gpm', authenticateToken, async (req, res) => {
    const { 
        NamaGpm, 
        Nip, 
        phone, 
    } = req.body;

    try {
        const hashedPassword = bcrypt.hashSync("gpm123", 10);
        const query = 'INSERT INTO gpm (NamaGpm, Nip, passwordGpm, phone) VALUES ( ?, ?, ?, ?)';
        const [result] = await db.query(query, [NamaGpm, Nip, hashedPassword, phone]);
        if (result.affectedRows > 0) {
            res.status(201).json({ message: 'GPM added successfully' });
        } else {
            res.status(500).json({ message: 'Failed to add GPM' });
        }
    } catch (error) {
        console.error('Error adding GPM:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// PUT untuk update password gpm
app.put('/update/gpm/:IdGpm', authenticateToken, async (req, res) => {
    const IdGpm = req.params.IdGpm;
    const { NamaGpm, Nip, phone, password } = req.body;

    // Jika tidak ada data yang berubah
    if (!NamaGpm && !Nip && !phone && !password) {
        return res.status(400).json({ message: 'Tidak ada data yang dikirim' });
    }

    try {
        let updates = [];
        let value = [];

        if (NamaGpm) {
            updates.push('NamaGpm = ?');
            value.push(NamaGpm);
        }

        if (Nip) {
            updates.push('Nip = ?');
            value.push(Nip);
        }

        if (phone) {
            updates.push('phone = ?');
            value.push(phone);
        }

        if (password) {
            const hashedPassword = hashPassword(password);
            updates.push('passwordGpm = ?');
            value.push(hashedPassword);
        }

        // Tambah IdGpm ke dalam parameter
        value.push(IdGpm);

        const query = `UPDATE gpm SET ${updates.join(', ')} WHERE IdGpm = ?`;
        const [result] = await db.query(query, value);
        
        // Cek baris yang diupdate
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'GPM updated successfully' });
        } else {
            res.status(404).json({ message: 'GPM not found' });
        }
    } catch (error) {
        console.error('Error updating GPM:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }

});

// DELETE gpm dari tabel gpm
app.delete('/delete/gpm/:IdGpm', authenticateToken, async (req, res) => {
    const IdGpm = req.params.IdGpm;

    try {
        const query = 'DELETE FROM gpm WHERE IdGpm = ?';
        const [result] = await db.query(query, [IdGpm]);
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'GPM deleted successfully' });
        } else {
            res.status(404).json({ message: 'GPM not found' });
        }
    } catch (error) {
        console.error('Error deleting GPM:', error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

// GET all data perwalian
app.get('/perwalian', authenticateToken, async (req, res) => {
    try {
        //  LEFT JOIN dengan tabel dosen untuk mendapatkan data NamaDosen berdasarkan IdDosen
        const query = `
            SELECT perwalian.*, dosen.NamaDosen, dosen.Nip
            FROM perwalian
            LEFT JOIN dosen ON perwalian.IdDosen = dosen.IdDosen
        `;
        const [rows] = await db.query(query);

        if (rows.length > 0) {
            // Jika kolom image_path ada, pastikan nilainya ada
            const results = rows.map(row => ({
                ...row,
                image_path: row.image_path ? `/${row.image_path}` : null,
            }));

            res.json(results);
        } else {
            res.status(404).json({ message: 'Data perwalian not found' });
        }
    } catch (error) {
        console.error('Error fetching data perwalian:', error);
        res.status(500).json({ message: 'Error fetching data perwalian' });
    }
});

// GET perwalian berdasarkan ID mahasiswa yang login
app.get('/perwalian-mahasiswa', authenticateToken, async (req, res) => {
    try {
        const idMaha = req.user.id; // Ambil IdMaha dari user yang terautentikasi
        // ambil data perwalian dengan join data NamaDosen dari tabel dosen
        const query = `
            SELECT perwalian.*, dosen.NamaDosen
            FROM perwalian
            JOIN dosen ON perwalian.IdDosen = dosen.IdDosen
            WHERE perwalian.IdMaha = ?`;
        const [rows] = await db.query(query, [idMaha]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Perwalian not found' });
        }
    } catch (error) {
        console.error('Error fetching perwalian:', error);
        res.status(500).json({ message: 'Error fetching perwalian' });
    }
});

// GET perwalian berdasarkan Id
app.get('/perwalian/:IdPerwalian', authenticateToken, async (req, res) => {
    const IdPerwalian = req.params.IdPerwalian;

    try {
        const query = 'SELECT * FROM perwalian WHERE IdPerwalian = ?';
        const [rows] = await db.query(query, [IdPerwalian]);

        if (rows.length > 0) {
            res.json(rows[0]);
        } else {
            res.status(404).json({ message: 'Perwalian not found' });
        }
    } catch (error) {
        console.error('Error fetching perwalian:', error);
        res.status(500).json({ message: 'Error fetching perwalian' });
    }
});

// GET perwalian data based on the authenticated dosen
app.get('/perwalian-dosen', authenticateToken, async (req, res) => {
    try {
        const idDosen = req.user.id; // Ambil IdDosen dari user yang terautentikasi
        const query = `
            SELECT p.*, m.NamaMaha, m.NimMaha, m.Alamat, m.phone, m.Semester, m.Ipk, m.Sks, d.NamaDosen, d.Nip
            FROM perwalian p
            JOIN mahasiswa m ON p.IdMaha = m.IdMaha 
            JOIN dosen d ON p.IdDosen = d.IdDosen
            WHERE p.IdDosen = ?`; // Ubah m.IdDosen menjadi p.IdDosen untuk menampilkan perwalian berdasarkan IdDosen yang dipilih
        const [rows] = await db.query(query, [idDosen]);

        if (rows.length > 0) {
            // Jika kolom image_path ada, pastikan ada nilainya
            const results = rows.map(row => ({
                ...row,
                image_path: row.image_path ? `/${row.image_path}` : null,
            }));

            res.json(results);
        } else {
            res.status(404).json({ message: 'Data perwalian not found' });
        }
    } catch (error) {
        console.error('Error fetching perwalian data:', error);
        res.status(500).json({ message: 'Error fetching perwalian data' });
    }
});

// POST endpoint perwalian
app.post('/add-perwalian', authenticateToken, async(req, res) => {
    const IdMaha = req.user.id;
    const {
        NamaMaha,
        NimMaha,
        DosenWali,
        NamaOrtu,
        PhoneOrtu,
        Alamat,
        Semester,
        TanggalPerwalian,
        Ipk,
        Sks,
        phone,
        uraian,
        masalah,
        IdDosen
    } = req.body;

    try {

        // Query untuk membuat perwalian
        const query = 'INSERT INTO perwalian (IdMaha, NamaMaha, NimMaha, DosenWali, NamaOrtu, PhoneOrtu, Alamat, Semester, TanggalPerwalian, Ipk, Sks, phone, uraian, masalah, IdDosen) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';

        const [result] = await db.query(query, [IdMaha, NamaMaha, NimMaha, DosenWali, NamaOrtu, PhoneOrtu, Alamat, Semester, TanggalPerwalian, Ipk, Sks, phone, uraian, masalah, IdDosen]);
        
        if (result.affectedRows > 0) {
            res.status(201).json({ message: 'Perwalian added successfully' });
        } else {
            res.status(500).json({ message: 'Failed to add perwalian' });
        }
    } catch (error) {
        console.error('Error adding perwalian:', error);
        res.status(500).json({ message: 'Error adding perwalian' });
    }
});

// GET all data info
app.get('/info', authenticateToken, async (req, res) => {
    const query = `
        SELECT info.*, dosen.NamaDosen 
        FROM info 
        JOIN dosen 
        ON info.IdDosen = dosen.IdDosen`;
    try {
        const [rows] = await db.query(query);
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error retrieving data from database');
    }
});

// GET info berdasarkan IdDosen untuk mahasiswa
app.get('/info-mahasiswa', authenticateToken, async (req, res) => {
    try {
        const idMaha = req.user.id; // Ambil IdMahasiswa dari user yang terautentikasi
        const query = `
            SELECT info.*, dosen.NamaDosen 
            FROM info 
            JOIN dosen ON info.IdDosen = dosen.IdDosen 
            JOIN mahasiswa ON dosen.IdDosen = mahasiswa.IdDosen 
            WHERE mahasiswa.IdMaha = ?`;
        const [rows] = await db.query(query, [idMaha]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Info not found' });
        }
    } catch (error) {
        console.error('Error fetching info:', error);
        res.status(500).json({ message: 'Error fetching info' });
    }
});

// GET info berdasarkan IdDosen untuk dosen 
app.get('/info-dosen', authenticateToken, async (req, res) => {
    try {
        const idDosen = req.user.id; // Ambil IdDosen dari user yang terautentikasi
        const query = `
            SELECT info.*, dosen.NamaDosen 
            FROM info 
            JOIN dosen ON info.IdDosen = dosen.IdDosen 
            WHERE dosen.IdDosen = ?`;
        const [rows] = await db.query(query, [idDosen]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Info not found' });
        }
    } catch (error) {
        console.error('Error fetching info:', error);
        res.status(500).json({ message: 'Error fetching info' });
    }
});

// POST info untuk dosen
app.post('/info-dosen', authenticateToken, async (req, res) => {
    const IdDosen = req.user.id;
    const { JudulInfo, Isi } = req.body;

    try {
        const query = 'INSERT INTO info (IdDosen, JudulInfo, Isi) VALUES (?, ?, ?)';
        const [result] = await db.query(query, [IdDosen, JudulInfo, Isi]);
        if (result.affectedRows > 0) {
            res.status(201).json({ message: 'Info added successfully' });
        } else {
            res.status(500).json({ message: 'Failed to add info' });
        }
    } catch (error) {
        console.error('Error adding info:', error);
        res.status(500).json({ message: 'Error adding info' });
    }
});

// DELETE info dosen
app.delete('/info-dosen/:IdInfo', authenticateToken, async (req, res) => {
    const IdInfo = req.params.IdInfo;

    try {
        const query = 'DELETE FROM info WHERE IdInfo = ?';
        const [result] = await db.query(query, [IdInfo]);
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Info deleted successfully' });
        } else {
            res.status(404).json({ message: 'Info not found' });
        }
    } catch (error) {
        console.error('Error deleting info:', error);
        res.status(500).json({ message: 'Error deleting info' });
    }
});

// GET info berdasarkan Id
app.get('/info/:id', async (req, res) => {
    const infoId = req.params.id;

    try {
        const query = `SELECT * FROM info WHERE IdInfo = ?`;
        const [rows] = await db.query(query, [infoId]);

        if (rows.length > 0) {
            const infoData = rows[0];
            res.json(infoData);
        } else {
            res.status(404).json({ message: 'Info not found' });
        }
    } catch (error) {
        console.error('Error fetching info:', error);
        res.status(500).json({ message: 'Error fetching info' });
    }
});

app.post('/survei', authenticateToken, async(req, res) => {
    const IdMaha = req.user.id;

    const {
        Semester,
        merasa_cemas, 
        merasa_bingung, 
        menarik_diri, 
        merasa_bosan,
        merasa_tidak_puas, 
        merasa_lelah, 
        tidak_dapat_mencari_jalan_keluar,
        tidak_dapat_berkonsentrasi, 
        merasa_tidak_kreatif, 
        merasa_tidak_tahu,
        merasa_tidak_percaya_diri, 
        detak_jantung_berdebar, 
        lambung_terasa_perih,
        mudah_keluar_keringat_dingin, 
        kepala_pusing, 
        susah_tidur,
        merasa_mudah_mengantuk, 
        menunda_tugas, 
        bolos_kuliah,
        kehilangan_nafsu_makan, 
        komunikasi_kurang_baik
    } = req.body;

    const totalScore =
                merasa_cemas +
                merasa_bingung +
                menarik_diri +
                merasa_bosan +
                merasa_tidak_puas +
                merasa_lelah +
                tidak_dapat_mencari_jalan_keluar +
                tidak_dapat_berkonsentrasi +
                merasa_tidak_kreatif +
                merasa_tidak_tahu +
                merasa_tidak_percaya_diri +
                detak_jantung_berdebar +
                lambung_terasa_perih +
                mudah_keluar_keringat_dingin +
                kepala_pusing +
                susah_tidur +
                merasa_mudah_mengantuk +
                menunda_tugas +
                bolos_kuliah +
                kehilangan_nafsu_makan +
                komunikasi_kurang_baik;
    try {
        const query = `INSERT INTO survei (
            IdMaha, 
            Semester,
            merasa_cemas, 
            merasa_bingung, 
            menarik_diri, 
            merasa_bosan,
            merasa_tidak_puas, 
            merasa_lelah, 
            tidak_dapat_mencari_jalan_keluar,
            tidak_dapat_berkonsentrasi, 
            merasa_tidak_kreatif, 
            merasa_tidak_tahu,
            merasa_tidak_percaya_diri, 
            detak_jantung_berdebar, 
            lambung_terasa_perih,
            mudah_keluar_keringat_dingin, 
            kepala_pusing, 
            susah_tidur,
            merasa_mudah_mengantuk, 
            menunda_tugas, 
            bolos_kuliah,
            kehilangan_nafsu_makan, 
            komunikasi_kurang_baik, 
            total_nilai
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

        const [result] = await db.query(query, [
            IdMaha,
            Semester,
            merasa_cemas,
            merasa_bingung,
            menarik_diri,
            merasa_bosan,
            merasa_tidak_puas,
            merasa_lelah,
            tidak_dapat_mencari_jalan_keluar,
            tidak_dapat_berkonsentrasi,
            merasa_tidak_kreatif,
            merasa_tidak_tahu,
            merasa_tidak_percaya_diri,
            detak_jantung_berdebar,
            lambung_terasa_perih,
            mudah_keluar_keringat_dingin,
            kepala_pusing,
            susah_tidur,
            merasa_mudah_mengantuk,
            menunda_tugas,
            bolos_kuliah,
            kehilangan_nafsu_makan,
            komunikasi_kurang_baik,
            totalScore
        ]);

        if (result.affectedRows > 0) {
            res.status(201).json({ message: 'Survei created successfully' });
        } else {
            res.status(500).json({ message: 'Failed to create survei' });
        }
    } catch (error) {
        console.error('Error creating survei:', error);
        res.status(500).json({ message: 'Error creating survei' });
    }
});

// PATCH untuk update kolom is_surveyed di tabel mahasiswa saat survei berhasil dikirim
app.patch('/update-survey-status', authenticateToken, async (req, res) => {
    const IdMaha  = req.user.id;

    try {
        const query = 'UPDATE mahasiswa SET is_surveyed = 1 WHERE IdMaha = ?';
        const [result] = await db.query(query, [ IdMaha]);

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Survey status updated successfully' });
        } else {
            res.status(404).json({ message: 'Survey not found' });
        }
    } catch (error) {
        console.error('Error updating survey status:', error);
        res.status(500).json({ message: 'Error updating survey status' });
    }
});
    
// GET survei dari mahasiswa terkait untuk ditampilkan di dosen 
app.get('/hasil-survei', authenticateToken, async (req, res) => {
    const IdDosen = req.user.id;
    try {
        const query = `
            SELECT s.*, m.NamaMaha, m.NimMaha, m.phone 
            FROM survei s
            LEFT JOIN mahasiswa m ON s.IdMaha = m.IdMaha
            WHERE m.IdDosen = ?`;
        const [rows] = await db.query(query, [IdDosen]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Survei not found for the selected IdDosen' });
        }
    } catch (error) {
        console.error('Error fetching survei:', error);
        res.status(500).json({ message: 'Error fetching survei' });
    }
});

// GET jadwal perwalian berdasarkan IdDosen
app.get('/jadwal-dosen/:IdDosen', authenticateToken, async (req, res) => {
    try {
        const IdDosen = req.params.IdDosen;
        const query = `
            SELECT jp.*, d.NamaDosen, d.Nip 
            FROM jadwal_dosen jp
            JOIN dosen d ON jp.IdDosen = d.IdDosen 
            WHERE jp.IdDosen = ?`;
        const [rows] = await db.query(query, [IdDosen]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Jadwal perwalian not found for the selected IdDosen' });
        }
    } catch (error) {
        console.error('Error fetching jadwal perwalian:', error);
        res.status(500).json({ message: 'Error fetching jadwal perwalian' });
    }
});

// DELETE jadwal-dosen berdasarkan IdJadwal
app.delete('/jadwal-dosen/:IdJadwal', authenticateToken, async (req, res) => {
    const IdJadwal = req.params.IdJadwal;

    try {
        const query = 'DELETE FROM jadwal_dosen WHERE IdJadwal = ?';
        const [result] = await db.query(query, [IdJadwal]);

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Jadwal deleted successfully' });
        } else {
            res.status(404).json({ message: 'Jadwal not found' });
        }
    } catch (error) {
        console.error('Error deleting jadwal:', error);
        res.status(500).json({ message: 'Error deleting jadwal' });
    }
});

// POST endpoint permintaan jadwal
app.post('/jadwal-perwalian', authenticateToken, async (req, res) => {
    const IdMaha = req.user.id; // Ambil IdMaha dari user terautentikasi
    const { jadwal_diajukan, IdDosen } = req.body;

    try {
        // Jika IdDosen tidak valid
        if (!IdDosen) {
            return res.status(400).json({ message: 'IdDosen tidak valid', success: false });
        }

        // Lakukan validasi jadwal diajukan
        if (!jadwal_diajukan) {
            return res.status(400).json({ message: 'Jadwal diajukan tidak boleh kosong', success: false });
        }

        // Query untuk membuat permintaan jadwal
        const query = `INSERT INTO jadwal_perwalian (IdMaha, IdDosen, jadwal_diajukan) VALUES (?, ?, ?)`;
        const [result] = await db.query(query, [IdMaha, IdDosen, jadwal_diajukan]);

        res.status(201).json({ message: 'Permintaan Jadwal Perwalian berhasil dibuat ', success: true });
    } catch (error) {
        console.error('Error creating permintaan jadwal:', error);
        res.status(500).json({ message: 'Error creating permintaan jadwal', success: false });
    }
});

// GET endpoint jadwal perwalian yang dapat dilihat mahasiswa yang login sesuai dengan ID maha
app.get('/jadwal-perwalian-maha', authenticateToken, async (req, res) => {
    const IdMaha = req.user.id; // Ambil IdMaha dari user terautentikasi

    try {
        const query = `
            SELECT jp.*, d.NamaDosen, d.Nip 
            FROM jadwal_perwalian jp
            JOIN dosen d ON jp.IdDosen = d.IdDosen 
            WHERE jp.IdMaha = ?`;
        const [rows] = await db.query(query, [IdMaha]);

        if (rows.length > 0) {
            res.json(rows);
        } else {
            res.status(404).json({ message: 'Jadwal perwalian not found for the selected IdMaha' });
        }
    } catch (error) {
        console.error('Error fetching jadwal perwalian:', error);
        res.status(500).json({ message: 'Error fetching jadwal perwalian' });
    }
});

// GET endpoint permintaan jadwal yang dapat dilihat dosen terhadap permintaan jadwal mahasiswa terkait
app.get('/jadwal-perwalian', authenticateToken, async (req, res) => {
    const userId = req.user.id; // Ambil IdDosen dari user terautentikasi

    try {
        let query;
        let queryParams;

        // Cek role user
        if (req.user.role === 'dosen') {
            // Jika user adalah dosen, ambil jadwal perwalian yang diajukan kepadanya
            query = `
                SELECT jp.*, m.NamaMaha, m.NimMaha, m.Semester, m.phone
                FROM jadwal_perwalian jp
                JOIN mahasiswa m ON jp.IdMaha = m.IdMaha
                WHERE jp.IdDosen = ?`; // Ambil jadwal perwalian berdasarkan ID Dosen

            queryParams = [userId];
        } else if (req.user.role === 'mahasiswa') {
            // Jika user adalah mahasiswa, ambil jadwal perwalian yang diajukan olehnya
            query = `
                SELECT jp.*, m.NamaMaha, d.NamaDosen, d.PhoneDosen
                FROM jadwal_perwalian jp
                LEFT JOIN mahasiswa m ON jp.IdMaha = m.IdMaha
                LEFT JOIN dosen d ON jp.IdDosen = d.IdDosen
                WHERE jp.IdMaha = ?`; // Ambil jadwal perwalian berdasarkan ID Mahasiswa

            queryParams = [userId];
        } else {
            // Jika user bukan dosen atau mahasiswa, kirim respon error
            return res.status(403).json({ message: 'Forbidden: Unauthorized user' });
        }

        const [rows] = await db.query(query, queryParams);

        if (rows.length > 0) {
            res.status(201).json(rows);
        } else {
            res.status(404).json({ message: 'Data permintaan jadwal not found for this dosen' });
        }
    } catch (error) {
        console.error('Error fetching permintaan jadwal:', error);
        res.status(500).json({ message: 'Error fetching permintaan jadwal' });
    }
});

// PUT endpoint untuk menolak permintaan jadwal
app.put('/reject-permintaan/:idPermintaan', async (req, res) => {
    const { idPermintaan } = req.params;
    const rejectConfirm = req.body.keterangan;

    try {
        const query = `UPDATE jadwal_perwalian SET status = 'Rejected', keterangan = ? WHERE IdPermintaan = ?`;
        const [result] = await db.query(query, [rejectConfirm, idPermintaan]);

        res.status(200).json({ success: true, message: 'Permintaan jadwal berhasil ditolak' });
    } catch (error) {
        console.error('Error rejecting permintaan jadwal:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan saat menolak permintaan jadwal' });
    }
});

// PUT endpoint untuk menyetujui permintaan jadwal
app.put('/approve-permintaan/:idPermintaan', async (req, res) => {
    const { idPermintaan } = req.params;

    try {
        const query = `UPDATE jadwal_perwalian SET status = 'Approved', keterangan = null WHERE IdPermintaan = ?`;
        const [result] = await db.query(query, [idPermintaan]);

        res.status(200).json({ success: true, message: 'Permintaan jadwal berhasil disetujui' });
    } catch (error) {
        console.error('Error approving permintaan jadwal:', error);
        res.status(500).json({ success: false, message: 'Terjadi kesalahan saat menyetujui permintaan jadwal' });
    }
});

// Multer storage configuration
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads'); // Save uploaded files to the 'uploads' directory
    },
    
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`); // Generate unique file names
    },
});

const upload = multer({ storage });

// POST endpoint for uploading data to the database
app.post('/upload-mahasiswa', upload.single('file'), async (req, res) => {
    try {
        // Ensure the file is uploaded
        if (!req.file) {
            return res.status(400).json({ message: 'No file uploaded' });
        }

        // Read the Excel file
        const filePath = path.join(__dirname, 'uploads', req.file.filename);
        const workbook = xlsx.readFile(filePath);
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const data = xlsx.utils.sheet_to_json(worksheet);

        const skippedEntries = [];

        // Insert data into the database
        for (const row of data) {
            const { NamaMaha, NimMaha, gender, agama, TahunMasuk, JalurMasuk, Alamat, Semester, Sks, Ipk, phone, status, IdDosen } = row;

            // Check if the student already exists
            const [existingMahasiswa] = await db.query('SELECT * FROM mahasiswa WHERE NimMaha = ?', [NimMaha]);

            if (existingMahasiswa.length > 0) {
                console.log(`Mahasiswa with NIM ${NimMaha} already exists. Skipping insertion.`);
                skippedEntries.push({ NamaMaha, NimMaha });
                continue; // Skip this row and move to the next
            }

            // Validate NamaMaha (only letters and spaces)
            const isNamaValid = /^[a-zA-Z\s]+$/.test(NamaMaha);
            const isNimValid = /^[0-9]+$/.test(NimMaha); // Validate NimMaha (only numbers)

            if (!isNamaValid) {
                skippedEntries.push({ NamaMaha, NimMaha, reason: 'Nama contains invalid characters' });
                continue;
            }

            if (!isNimValid) {
                skippedEntries.push({ NamaMaha, NimMaha, reason: 'NIM is invalid' });
                continue;
            }

            // Encrypt default password
            const hashedPassword = bcrypt.hashSync('mahasiswa123', 10);

            // Query to insert data into the database
            const query = 'INSERT INTO mahasiswa (NamaMaha, NimMaha, gender, agama, TahunMasuk, JalurMasuk, Alamat, Semester, Sks, Ipk, phone, status, IdDosen, passwordMaha) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
            await db.query(query, [NamaMaha, NimMaha, gender, agama, TahunMasuk, JalurMasuk, Alamat, Semester, Sks, Ipk, phone, status, IdDosen, hashedPassword]);

            console.log(`Data for ${NamaMaha} (${NimMaha}) inserted successfully`);
        }

        res.status(201).json({ message: 'Data Mahasiswa imported successfully', skippedEntries });
    } catch (error) {
        console.error('Error importing data Mahasiswa:', error);
        res.status(500).json({ message: 'Error importing data Mahasiswa' });
    }
});

app.post("/update-mahasiswa", upload.single("file"), async (req, res) => {
  try {
    // Ensure the file is uploaded
    if (!req.file) {
      return res.status(400).json({ message: "No file uploaded" });
    }

    // Read the Excel file
    const filePath = path.join(__dirname, "uploads", req.file.filename);
    const workbook = xlsx.readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];
    const data = xlsx.utils.sheet_to_json(worksheet);

    const skippedEntries = [];
    let anyRecordUpdated = false;

    // Insert data into the database
    for (const row of data) {
      const {
        NamaMaha,
        NimMaha,
        gender,
        agama,
        TahunMasuk,
        JalurMasuk,
        Alamat,
        Semester,
        Sks,
        Ipk,
        phone,
        status,
        IdDosen,
      } = row;

      // Check Mahasiswa dengan Nim yang sama
      const [existingMahasiswa] = await db.query(
        "SELECT * FROM mahasiswa WHERE NimMaha = ?", [NimMaha] );

      if (existingMahasiswa.length === 0) {
        console.log(
          `Mahasiswa with NIM ${NimMaha} not found. Skipping insertion.`
        );
        skippedEntries.push({ NamaMaha, NimMaha });
        continue; // Skip Kolom yang tidak ada perubahan
      }

      // valisa NamaMaha (only letters and spaces)
      const isNamaValid = /^[a-zA-Z\s]+$/.test(NamaMaha);
      const isNimValid = /^[0-9]+$/.test(NimMaha); // validasi only number NimMaha

      if (!isNamaValid) {
        skippedEntries.push({
          NamaMaha,
          NimMaha,
          reason: "Nama contains invalid characters",
        });
        continue;
      }

      if (!isNimValid) {
        skippedEntries.push({ NamaMaha, NimMaha, reason: "NIM is invalid" });
        continue;
      }

      // Check for changes
      let updates = [];
      let updateValue = [];
      let isSemesterChanged = false;

      if (NamaMaha) {
        updates.push("NamaMaha = ?");
        updateValue.push(NamaMaha);
      }
      if (gender) {
        updates.push("gender = ?");
        updateValue.push(gender);
      }
      if (agama) {
        updates.push("agama = ?");
        updateValue.push(agama);
      }
      if (TahunMasuk) {
        updates.push("TahunMasuk = ?");
        updateValue.push(TahunMasuk);
      }
      if (JalurMasuk) {
        updates.push("JalurMasuk = ?");
        updateValue.push(JalurMasuk);
      }
      if (Alamat) {
        updates.push("Alamat = ?");
        updateValue.push(Alamat);
      }
      if (Semester && Semester !== existingMahasiswa[0].Semester) {
        updates.push("Semester = ?");
        updateValue.push(Semester);
        // If semester changes, set is_surveyed to 0
        updates.push("is_surveyed = ?");
        updateValue.push(0);
        isSemesterChanged = true;
      }
      if (Sks) {
        updates.push("Sks = ?");
        updateValue.push(Sks);
      }
      if (Ipk) {
        updates.push("Ipk = ?");
        updateValue.push(Ipk);
      }
      if (phone) {
        updates.push("phone = ?");
        updateValue.push(phone);
      }
      if (status) {
        updates.push("status = ?");
        updateValue.push(status);
      }
      if (IdDosen) {
        updates.push("IdDosen = ?");
        updateValue.push(IdDosen);
      }

      // Add NimMaha for update condition
      updateValue.push(NimMaha);

      // Perform update if there are changes
      if (updates.length > 0) {
                const query = `UPDATE mahasiswa SET ${updates.join(", ")} WHERE NimMaha = ?`;
                const result = await db.query(query, updateValue);

                if (result.affectedRows > 0) {
                    anyRecordUpdated = true; // Mark that at least one record was updated
                } else {
                    console.log(`Mahasiswa with NIM ${NimMaha} did not update`);
                    skippedEntries.push({ NamaMaha, NimMaha, reason: "No changes detected" });
                }
            } else {
                skippedEntries.push({ NamaMaha, NimMaha, reason: "No changes to update" });
            }
        }

        // Only respond if there were updates
        if (anyRecordUpdated) {
            res.status(201).json({
                message: "Data Mahasiswa imported successfully",
                skippedEntries,
            });
        } else {
            res.status(200).json({
                message: "No changes detected. File was not processed.",
                skippedEntries,
            });
        }
    } catch (error) {
        console.error("Error importing data Mahasiswa:", error);
        res.status(500).json({ message: "Error importing data Mahasiswa" });
    }
});

// POST import jadwal dosen
app.post('/upload-jadwal-dosen', upload.single('file'), async (req, res) => {
    try {
        const filePath = path.join(__dirname,'uploads', req.file.filename);
        const workbook = xlsx.readFile(filePath);
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const data = xlsx.utils.sheet_to_json(worksheet);

        // Insert data into database
        for (const row of data) {
            const { IdDosen, Hari, Waktu, MataKuliah, Kelas, Pengampu, Ruangan } = row;
            const query = 'INSERT INTO jadwal_dosen (IdDosen, Hari, Waktu, MataKuliah, Kelas, Pengampu, Ruangan) VALUES ( ?, ?, ?, ?, ?, ?, ?)';
            await db.query(query, [IdDosen, Hari, Waktu, MataKuliah, Kelas, Pengampu, Ruangan]);
        }

        res.status(201).json({ message: 'Data Jadwal Dosen imported successfully' });
    } catch (error) {
        console.error('Error importing data Jadwal Dosen:', error);
        res.status(500).json({ message: 'Error importing data Jadwal Dosen' });
    }
});

// PUT untuk update perwalian kolom rekomendasi berdasarkan IdPerwalian
app.put('/update/perwalian/:idPerwalian', authenticateToken, upload.single('file'), async(req, res) => {
    const IdPerwalian = req.params.idPerwalian;
    const { rekomendasi } = req.body;

    const filePath = req.file ? req.file.path : null;

    // Update rekomendasi dan image_path dari frontend ke database
    const query = 'UPDATE perwalian SET rekomendasi = ?, image_path = ? WHERE IdPerwalian = ?';

    try {
        const [result] = await db.query(query, [rekomendasi, filePath, IdPerwalian]);
        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Perwalian updated successfully' });
        } else {
            res.status(404).json({ message: 'Perwalian not found' });
        }
    } catch (error) {
        console.error('Error updating perwalian:', error);
        res.status(500).json({ message: 'Error updating perwalian' });
    }

});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
});
