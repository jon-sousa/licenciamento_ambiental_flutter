class Usuario {
  String nome;
  String cpf;
  String endereco;
  String telefone;
  String? senha;

  Usuario(
      {required String nome,
      required String cpf,
      required String telefone,
      required String endereco,
      String? senha})
      : this.nome = nome,
        this.cpf = cpf,
        this.telefone = telefone,
        this.endereco = endereco,
        this.senha = senha;

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "endereco": endereco,
      "senha": senha ?? '',
    };
  }

  fromMap(Map<String, dynamic> map) {
    if (map.containsKey('nome')) {
      nome = map['nome'];
    }

    if (map.containsKey('cpf')) {
      cpf = map['cpf'];
    }

    if (map.containsKey('telefone')) {
      telefone = map['telefone'];
    }

    if (map.containsKey('endereco')) {
      endereco = map['endereco'];
    }
  }
}
