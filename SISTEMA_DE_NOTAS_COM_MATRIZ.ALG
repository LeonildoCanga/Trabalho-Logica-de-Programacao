Algoritmo "GestaoEscolar_Completo_2026"

Var
   // --- ESTRUTURA DE DADOS ---
   id_turmas      : vetor[1..5] de caractere
   matriz_nomes   : vetor[1..5, 1..20] de caractere
   matriz_medias  : vetor[1..5, 1..20] de real
   matriz_notas   : vetor[1..100, 1..8] de real

   // --- CONTROLE E AUXILIARES ---
   turma, aluno, bimestre, n_prova, col_nota, idx : inteiro
   opcao_menu, t_sel : inteiro
   soma_aluno, nota_temp : real
   achou_aprovado : logico // Para verificar se alguém foi encontrado

   // --- RANKING ---
   v_rank_nomes  : vetor[1..20] de caractere
   v_rank_medias : vetor[1..20] de real
   temp_nome     : caractere
   temp_media    : real
   i, j : inteiro

Inicio
   // --- 1. ENTRADA DE DADOS (5 Turmas x 20 Alunos) ---
   para turma de 1 ate 5 faca
      escreval("=== CADASTRO DA TURMA ", turma, " ===")
      escreva("Nome da Turma (Ex: 10A): ")
      leia(id_turmas[turma])

      para aluno de 1 ate 20 faca
         idx <- ((turma - 1) * 20) + aluno
         escreval("Turma ", id_turmas[turma], " - Aluno ", aluno, "/20")
         escreva("Nome: ")
         leia(matriz_nomes[turma, aluno])

         soma_aluno <- 0
         col_nota <- 1

         para bimestre de 1 ate 4 faca
            para n_prova de 1 ate 2 faca
               repita
                  escreva("  ", bimestre, "ºB, Nota ", n_prova, ": ")
                  leia(nota_temp)
               ate (nota_temp >= 0) e (nota_temp <= 20)

               matriz_notas[idx, col_nota] <- nota_temp
               soma_aluno <- soma_aluno + nota_temp
               col_nota <- col_nota + 1
            fimpara
         fimpara
         matriz_medias[turma, aluno] <- soma_aluno / 8
      fimpara
      limpatela
   fimpara

   // --- 2. MENU PRINCIPAL ---
   repita
      escreval("=======================================")
      escreval("       SISTEMA DE GESTÃO ESCOLAR       ")
      escreval("=======================================")
      escreval("1 - CONSULTAR NOTAS POR TURMA")
      escreval("2 - RANKING (TOP 20 POR TURMA)")
      escreval("3 - ALUNOS ACIMA DA MÉDIA (GERAL)") // Nova Opção
      escreval("4 - SAIR")
      escreva("Escolha: ")
      leia(opcao_menu)
      limpatela

      escolha opcao_menu
         caso 1
            escreval("Selecione a Turma (1-5):")
            para i de 1 ate 5 faca: escreval(i, " - ", id_turmas[i]) : fimpara
            leia(t_sel)
            limpatela
            escreval("NOTAS DA TURMA: ", id_turmas[t_sel])
            para aluno de 1 ate 20 faca
               escreval(matriz_nomes[t_sel, aluno]:20, "| Média: ", matriz_medias[t_sel, aluno]:4:1)
            fimpara
            escreva("Pressione Enter...")
            leia(temp_nome)

         caso 2
            escreva("Ranking de qual turma (1-5)? ")
            leia(t_sel)
            para i de 1 ate 20 faca
               v_rank_nomes[i]  <- matriz_nomes[t_sel, i]
               v_rank_medias[i] <- matriz_medias[t_sel, i]
            fimpara
            para i de 1 ate 19 faca
               para j de i+1 ate 20 faca
                  se v_rank_medias[i] < v_rank_medias[j] entao
                     temp_media <- v_rank_medias[i]; v_rank_medias[i] <- v_rank_medias[j]; v_rank_medias[j] <- temp_media
                     temp_nome <- v_rank_nomes[i]; v_rank_nomes[i] <- v_rank_nomes[j]; v_rank_nomes[j] <- temp_nome
                  fimse
               fimpara
            fimpara
            escreval("RANKING TOP 20 - ", id_turmas[t_sel])
            para i de 1 ate 20 faca: escreval(i, "º: ", v_rank_nomes[i]:20, " - ", v_rank_medias[i]:4:1) : fimpara
            escreva("Pressione Enter...")
            leia(temp_nome)

         caso 3
            // --- LÓGICA: ALUNOS ACIMA DA MÉDIA GERAL ---
            achou_aprovado <- falso
            escreval("--- ALUNOS COM DESEMPENHO POSITIVO (MÉDIA >= 10) ---")
            escreval("")

            para turma de 1 ate 5 faca
               escreval(">> TURMA: ", id_turmas[turma])
               para aluno de 1 ate 20 faca
                  // Verifica se a média do aluno é maior ou igual a 10
                  se (matriz_medias[turma, aluno] >= 10) entao
                     escreval("   Aluno: ", matriz_nomes[turma, aluno]:20, " | Média: ", matriz_medias[turma, aluno]:4:1)
                     achou_aprovado <- verdadeiro
                  fimse
               fimpara
               escreval("-------------------------------------------")
            fimpara

            se (nao achou_aprovado) entao
               escreval("Nenhum aluno atingiu a média mínima em nenhuma turma.")
            fimse

            escreva("Pressione Enter para voltar...")
            leia(temp_nome)
            limpatela

         caso 4
            escreval("Saindo...")
      fimescolha
   ate opcao_menu = 4
Fimalgoritmo