main(List<String> args) {
  Set<String> pessoasSemDuplicidade = Set();

  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Masculino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];
  //Colocando as pessoas no SET para pegar somente os diferentes.
  pessoas.forEach((pessoa) {
    pessoasSemDuplicidade.add(pessoa);
  });
  // Baseado na lista acima.
  // 1 - Remover os duplicados
  // 2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  // 3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos
  //     e mostre a quantidade de pessoas com mais de 18 anos
  // 4 - Encontre a pessoa mais velha.

  contabilizarPessoas(pessoasSemDuplicidade);
}

void contabilizarPessoas(Set<String> pessoasSemDuplicidade) {
  List<String> pessoasMaioresdeIdade = retornarSomenteMaioresdeIdade(pessoasSemDuplicidade);
  Map<String, dynamic> dadosFiltrados = processarDados(pessoasMaioresdeIdade);
  Map<String, dynamic> pessoasPorSexo = dadosFiltrados['pessoasPorSexo'];
  print("===== Resposta do exercício ===== ");
  print("Existem ${dadosFiltrados['qtdMasculino']} homens e ${dadosFiltrados['qtdFeminino']} mulheres na lista sem duplicidade separados da seguinte forma:");

  pessoasPorSexo.forEach((sexo, pessoas) {
    print("Sexo ${sexo} ");
    pessoas.forEach((pessoa) {
      print("\t|_" + pessoa);
    });
  });

  print("Dentre eles, ${dadosFiltrados['pessoaMaisVelha']['nome']} é o(a) mais velho(a) com ${dadosFiltrados['pessoaMaisVelha']['idade']} anos ");
}

Map<String, dynamic> processarDados(List<String> pessoasMaioresdeIdade) {
  int qtdMasculino = 0;
  int qtdFeminino = 0;
  Map<String, String> pessoaMaisVelha = {};
  Map<String, dynamic> pessoasPorSexo = {};
  pessoasMaioresdeIdade.forEach((pessoa) {
    List<String> dadosPessoa = dividirNome(pessoa, '|');
    dadosPessoa[2].compareTo('Masculino') == 0 ? (qtdMasculino++) : (qtdFeminino++);
    procurarPessoaMaisVelha(pessoaMaisVelha, dadosPessoa);
    separarPessoasPorSexo(pessoasPorSexo, dadosPessoa);
  });
  return {'qtdMasculino': qtdMasculino, 'qtdFeminino': qtdFeminino, 'pessoaMaisVelha': pessoaMaisVelha, 'pessoasPorSexo': pessoasPorSexo};
}

void separarPessoasPorSexo(Map<String, dynamic> pessoasPorSexo, List<String> dadosPessoa) {
  if (pessoasPorSexo[dadosPessoa[2]] == null) {
    pessoasPorSexo[dadosPessoa[2]] = List<String>();
  }
  pessoasPorSexo[dadosPessoa[2]].add(dadosPessoa[0]);
}

void procurarPessoaMaisVelha(Map<String, String> pessoaMaisVelha, List<String> dadosPessoa) {
  if (pessoaMaisVelha['idade'] == null) {
    pessoaMaisVelha['nome'] = dadosPessoa[0];
    pessoaMaisVelha['idade'] = dadosPessoa[1];
  } else {
    if (int.parse(pessoaMaisVelha['idade']) < int.parse(dadosPessoa[1])) {
      pessoaMaisVelha['nome'] = dadosPessoa[0];
      pessoaMaisVelha['idade'] = dadosPessoa[1];
    }
  }
}

List<String> dividirNome(String pessoa, String s) => (pessoa.split(s));
List<String> retornarSomenteMaioresdeIdade(Set<String> pessoasSemDuplicidade) {
  return pessoasSemDuplicidade.where((pessoa) {
    List<String> dadosPessoa = dividirNome(pessoa, '|');
    return (int.parse(dadosPessoa[1]) > 18);
  }).toList();
}
