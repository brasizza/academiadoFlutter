void main(List<String> args) {
  Map<String, dynamic> resultadoPacientes = {};
  Map<String, List<String>> resultadoFamilias = {};
  int idade = 20;
  var pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  // Baseado no array acima monte um relatório onde mostre
  // Apresente a quantidade de pacientes com mais de 20 anos
  // Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.
  resultadoPacientes = processarPacientes(pacientes, idade: idade);
  resultadoFamilias = resultadoPacientes['familias'];
  print("Existe(m) ${resultadoPacientes['idadeEscolhida']} paciente(s) com idade superior à  ${idade} anos");
  print("Separação de pacientes por Família");
  resultadoFamilias.forEach((familia, pessoasDaFamilia) {
    print("Familia ${familia}");
    pessoasDaFamilia.forEach((pessoa) {
      print("\t|_${pessoa}");
    });
  });
}

Map<String, dynamic> processarPacientes(List<String> pacientes, {idade = 20}) {
  Map<String, List<String>> familias = {};
  int idadePaciente = 0;
  String nomePaciente;
  List<String> nomePacienteSeparado = [];
  List<String> dadosPaciente = [];
  pacientes.forEach((paciente) {
    dadosPaciente.clear();
    dadosPaciente = paciente.split('|');
    //* Pegando os pacientes cujo a idade é maior que 20 anos!
    if (int.parse(dadosPaciente[1]) > 20) {
      idadePaciente++;
    }
    //* Separando o sobrenome com  espaço
    nomePacienteSeparado.clear();
    nomePaciente = dadosPaciente[0];
    nomePacienteSeparado = nomePaciente.split(" ");
    if (familias[nomePacienteSeparado[1]] == null) {
      familias[nomePacienteSeparado[1]] = List<String>();
    }
    familias[nomePacienteSeparado[1]].add(nomePacienteSeparado[0]);
  });
  return {'idadeEscolhida': idadePaciente, 'familias': familias};
}
