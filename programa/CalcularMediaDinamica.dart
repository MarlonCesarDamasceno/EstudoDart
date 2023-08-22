import 'dart:ffi';

import 'package:test/test.dart';
import 'dart:io';

int quantidadesNotasCorte = 3;
int controladorContadorNota = 0;
List<String> alunos = [];
Map<int, double> registroMediaAluno = {};

void main() {
  int escolhaMenuPrencipal;

  do {
    print(
        "Calculador de média dinamico. \nCadastre quantos alunos quiser e consulte de forma imediata a situação escolar de cada um.\n\n");

    print("Menu principal\n\n ");

    print(
        "Pressione 1 para cadastrar novos alunos e notas no sistema.\nPressione 2 para ver a situação escolar de cada aluno cadastrado no sistema.\nPara finalizar o programa, pressione 0.");
    escolhaMenuPrencipal = int.parse(stdin.readLineSync() ?? '');
    switch (escolhaMenuPrencipal) {
      case 1:
        _RegistrarAlunosNotas();
        break;
      case 2:
        _ExibirFechamentosMediasAlunos();
      case 0:
        print("Obrigado por utilizar o programa!");
        break;
        Defaulte:
        print("Opção inválida");
    }
  } while (escolhaMenuPrencipal != 0);
}

void _RegistrarAlunosNotas() {
  print("Cadastrar alunos e notas\n\n");
  int escolhaMenuCadastrarAluno;
  double nota;
  do {
    print(
        "Pressione 1 para cadastrar mais alunos. 2 para ver alunos cadastrados.\n3 para cadastrar as notas de cada aluno. Ou pressione 4 para voltar para o menu anterior\n ");
    escolhaMenuCadastrarAluno = int.parse(stdin.readLineSync() ?? '');

    switch (escolhaMenuCadastrarAluno) {
      case 1:
        print("Informe o nome do aluno (a)");
        String? nomeAluno = stdin.readLineSync();

        if (nomeAluno != null) {
          alunos.add(nomeAluno);
        } else {
          print("Nome não informado corretamente.");
        }

        print("Aluno (a) $nomeAluno cadastrado com sucesso.");
        break;
      case 2:
        if (alunos.length == 0) {
          print("Ainda não há alunos cadastrados.");
        } else {
          print(
              "Foram encontrados ${alunos.length} alunos.\n\nPressione enter para ir passando os nomes cadastrados.\n\n");
          for (int aluno = 0; aluno <= alunos.length - 1; aluno++) {
            int numeradorAluno = (aluno + 1);
            print("$numeradorAluno) ${alunos[aluno]}\n");
            stdin.readLineSync();
          }
        }
        break;
      case 3:
        if (alunos.length == 0) {
          print("Não há alunos cadastrados ainda.");
        } else {
          int indexAluno = 0;

          while (indexAluno <= alunos.length - 1) {
            print("Insira as notas de 1 a 3 para ${alunos[indexAluno]}\n");

            double calculoMedia = 0;
            for (int cadastroNota = 1;
                cadastroNota <= quantidadesNotasCorte;
                cadastroNota++) {
              print("informe a nota $cadastroNota:");
              calculoMedia += double.parse(stdin.readLineSync() ?? '');
              print("Nota cadastrada com sucesso! ; enter para continuar.");
            }
            _RegistrarMediasAlunos(indexAluno, calculoMedia);
            stdin.readLineSync();
            calculoMedia = 0;

            indexAluno++;
          }
        }
        break;
      case 4:
        print("Voltando para o menu principal");
        break;
      default:
        print("Opção inválida!");
    }
  } while (escolhaMenuCadastrarAluno != 4);
}

void _RegistrarMediasAlunos(int idAluno, double mediaObitida) {
  registroMediaAluno[idAluno] = mediaObitida / 3;
}

void _ExibirFechamentosMediasAlunos() {
  registroMediaAluno.forEach((aluno, mediaFinal) {
    print("Aluno (a): ${alunos[aluno]}\n");
    stdin.readLineSync();
    print("Nota final: $mediaFinal\n");
    stdin.readLineSync();
    print("Status: ");

    if (mediaFinal < 7) {
      print("reprovado. Não obteve nota de corte necessária.");
    } else {
      print("aprovado!\n");
    }
  });
}
