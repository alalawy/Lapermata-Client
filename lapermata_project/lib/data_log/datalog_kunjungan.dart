class DatalogKunjungan {
  final String id;
  final String kode;
  final String kodePngunjungUtama;
  final String kodeTahanan;
  final String kodeUrutan;
  final String kodeUser;
  final String status;
  final String tglKunjungan;

  DatalogKunjungan(
      this.id,
      this.kode,
      this.kodeTahanan,
      this.kodePngunjungUtama,
      this.kodeUrutan,
      this.kodeUser,
      this.status,
      this.tglKunjungan);
}

class DataUser {
  final String alamat;
  final String fotoKTP;
  final String fotoSelfie;
  final String id;
  final String kode;
  final String kodeUrutan;
  final String nama;
  final String noTelpon;
  final String pass;
  final String password;
  final String status;
  final String tahanan;

  DataUser(
    this.alamat,
    this.fotoKTP,
    this.fotoSelfie,
    this.id,
    this.kode,
    this.kodeUrutan,
    this.nama,
    this.noTelpon,
    this.pass,
    this.password,
    this.status,
    this.tahanan,
  );
}

class DataPengunjungUtama {
  final String id;
  final String alamat;
  final String fotoKtp;
  final String fotoSelfie;
  final String jenisKartu;
  final String jk;
  final String kamar;
  final String ket;
  final String kode;
  final String kodeUrutan;
  final String nama;
  final String hp;
  final String noKartu;
  final String pengikut;
  final String relasi;
  final String status;

  DataPengunjungUtama(
      this.id,
      this.kodeUrutan,
      this.kode,
      this.jenisKartu,
      this.noKartu,
      this.nama,
      this.alamat,
      this.jk,
      this.hp,
      this.relasi,
      this.pengikut,
      this.fotoKtp,
      this.fotoSelfie,
      this.kamar,
      this.ket,
      this.status);
}

class DataPengikut {
  final String id;
  final String alamat;
  final String fotoKtp;
  final String fotoSelfie;
  final String jenisKartu;
  final String jk;
  final String diIkuti;
  final String kode;
  final String kodeUrutan;
  final String nama;
  final String noKartu;
  final String relasi;
  final String status;

  DataPengikut(
      this.id,
      this.kodeUrutan,
      this.kode,
      this.jenisKartu,
      this.noKartu,
      this.nama,
      this.alamat,
      this.jk,
      this.relasi,
      this.fotoKtp,
      this.fotoSelfie,
      this.diIkuti,
      this.status);
}

class DataTahanan {
  final String id;
  final String nama;
  final String namaA1;
  final String namaA2;
  final String namaA3;
  final String namaK1;
  final String namaK2;
  final String namaK3;
  final String alamat;
  final String fotoTahanan;
  final String jk;
  final String kejahatan;
  final String kluarga;
  final String kewarganegaraan;
  final String negara;
  final String kode;
  final String kodeUrutan;
  final String noBerkas;
  final String noRegistrasi;
  final String status;
  final String statusTahanan;
  final String tglLahir;
  final String tglMasukUPT;
  final String tgnDitahan;

  DataTahanan(
      this.id,
      this.nama,
      this.namaA1,
      this.namaA2,
      this.namaA3,
      this.namaK1,
      this.namaK2,
      this.namaK3,
      this.alamat,
      this.fotoTahanan,
      this.jk,
      this.kejahatan,
      this.kluarga,
      this.kewarganegaraan,
      this.negara,
      this.kode,
      this.kodeUrutan,
      this.noBerkas,
      this.noRegistrasi,
      this.statusTahanan,
      this.status,
      this.tglLahir,
      this.tglMasukUPT,
      this.tgnDitahan);
}
