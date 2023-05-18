using System;

namespace ControleDeEstoque
{
    class Program
    {
        public static int ObterOpcaoMenu()
        {
            Console.WriteLine("CONTROLE DE ESTOQUE!!!");
            Console.WriteLine();
            Console.WriteLine("[1] Novo");
            Console.WriteLine("[2] Listar Produtos");
            Console.WriteLine("[3] Remover Produtos");
            Console.WriteLine("[4] Entrada Estoque");
            Console.WriteLine("[5] Saida Estoque");
            Console.WriteLine("[0] Sair");
            
            string input = Console.ReadLine();
            int opcao;
            bool conversaoValida = int.TryParse(input, out opcao);
            
            return opcao;
        }

        static void Main (string[] args)
        {
            List<string> nomes = new List<string>();
            List<decimal> valores = new List<decimal>();
            List<string> autores = new List<string>();
            List<string> generos = new List<string>();
            List<int> quantidades = new List<int>();

            int opcao = -1;
            
            // Lista para armazenar os produtos
            List<string> produtos = new List<string>();
            while (opcao != 0)
            {
                //função de menu
                opcao = ObterOpcaoMenu();
                ; 

                switch (opcao)
                {
                    case 1:
                        Console.WriteLine("Digite o nome do Livro:");
                        string nomeProduto = Console.ReadLine();

                        Console.WriteLine("Informe o Preço: ");
                        decimal valorProduto = decimal.Parse(Console.ReadLine());

                        Console.WriteLine("Informe o autor(a):");
                        string autorProduto = Console.ReadLine();

                        Console.WriteLine("Digite o gênero:");
                        string generoProduto = Console.ReadLine();

                        nomes.Add(nomeProduto);
                        valores.Add(valorProduto);
                        autores.Add(autorProduto);
                        generos.Add(generoProduto);
                        quantidades.Add(0);

                        Console.WriteLine("Livro adicionado com sucesso!");
                        Console.WriteLine();
                        break;
                        
                    case 2:
                        Console.WriteLine("Livros cadastrados:");
                        if (nomes.Count == 0)
                        {
                            Console.WriteLine("Sem produtos cadastrados.");
                        }
                        else
                        {
                            for (int i = 0; i < nomes.Count; i++)
                            {
                                Console.WriteLine($"Nome: {nomes[i]} | Valor: {valores[i]} | Autor: {autores[i]} | Gênero: {generos[i]} | Estoque: {quantidades[i]}" );
                            }
                        }
                        Console.WriteLine();
                        break;
                    case 3:
                        Console.WriteLine("Qual produto deseja remover:");
                        string nomeRemover = Console.ReadLine();

                        bool produtoRemovido = false;
                        for (int i = nomes.Count - 1; i >= 0; i--)
                        {
                            if (nomes[i].Equals(nomeRemover, StringComparison.OrdinalIgnoreCase))
                            {
                                nomes.RemoveAt(i);
                                valores.RemoveAt(i);
                                autores.RemoveAt(i);
                                generos.RemoveAt(i);
                                produtoRemovido = true;
                            }
                        }

                        if (produtoRemovido)
                        {
                            Console.WriteLine("Produto removido com sucesso!");
                        }
                        else
                        {
                            Console.WriteLine("Produto não identificado.");
                        }
                        Console.WriteLine();
                        break;
                    case 4:
                        Console.WriteLine("Digite o nome do produto que deseja adiconar no estoque:");
                        nomeProduto = Console.ReadLine();

                        int index = nomes.IndexOf(nomeProduto);
                        if (index != -1)
                        {
                            Console.WriteLine("Quantidade que deseja adicionar ao estoque:");
                            int quantidadeAdicionar = int.Parse(Console.ReadLine());

                            quantidades[index] += quantidadeAdicionar;
                            Console.WriteLine($"Estoque do produto {nomes[index]} atualizado. Você adicionou: {quantidadeAdicionar}");
                        }
                        else
                        {
                            Console.WriteLine("Produto não localizado.");
                        }
                        Console.WriteLine();
                        break;
                    case 5:
                        Console.WriteLine("Digite o nome do produto que deseja remover do estoque:");
                        nomeProduto = Console.ReadLine();

                        index = nomes.IndexOf(nomeProduto);
                        if (index != -1)
                        {
                            Console.WriteLine("Quantidade que deseja remover do estoque:");
                            string quantidadeInput = Console.ReadLine();
                            int quantidade;
                            if (int.TryParse(quantidadeInput, out quantidade))
                            {
                                if (quantidade <= quantidades[index])
                                {
                                    quantidades[index] -= quantidade;
                                    Console.WriteLine($"{quantidade} unidades removidas do estoque do produto {nomeProduto}. Estoque atual: {quantidades[index]}");
                                }
                                else
                                {
                                    Console.WriteLine("Quantidade maior que o estoque, Por favor revisar o valor para remoção.");
                                }
                            }
                            else
                            {
                                Console.WriteLine("Quantidade inválida.");
                            }
                        }
                        else
                        {
                            Console.WriteLine("Produto não encontrado.");
                        }
                        Console.WriteLine();
                        break;
                    default:
                        Console.WriteLine("Opção inválida.");
                        break;
                }
            
            Console.WriteLine(); // Linha em branco para separação
            }   
        }
    }
}