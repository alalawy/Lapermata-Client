class Validation {
  String validateNama(String value) {
    if (value.isEmpty) {
      return 'Nama Lengkap Harus Diisi';
    }
    return null;
  }
  String validateAlamat(String value) {
    if (value.isEmpty) {
      return 'Alamat Lengkap Harus Diisi';
    }
    return null;
  }

  String validateNomor(String value) {
    if (value.length < 8) {
      return 'Nomor Minimal 8 Karakter';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Password Minimal 4 Karakter';
    }
    return null;
  }
  String validatePasswordLogin(String value) {
    if (value.length < 1) {
      return 'Masukkan Password';
    }
    return null;
  }
  String validateNomorLogin(String value) {
    if (value.length <1) {
      return 'Masukkan Nomor';
    }
    return null;
  }

  String validateKeluarga(String value) {
    if (value.isEmpty) {
      return 'Pilih Keluarga Binaan';
    }
    return null;
  }
}
