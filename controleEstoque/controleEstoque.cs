using System;

public class HelloWorld
{
    List<string> nomes = new List<string>();
    List<decimal> valores = new List<decimal>();
    List<string> autores = new List<string>();
    List<string> generos = new List<string>();
    
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
    
    public static void Main(string[] args)
    {   
        int opcao = -1;
        // Lista para armazenar os produtos
        List<string> produtos = new List<string>();
        while (opcao != 0)
        {
            //função de menu
            opcao = ObterOpcaoMenu();
            
            // Faça algo com a opção selecionada
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

                    Console.WriteLine("Livro adicionado com sucesso!");
                    Console.WriteLine();
                    break;
                    
                case 2:
                    Console.WriteLine("Lista de Produtos:");
                    if (nomes.Count == 0)
                    {
                        Console.WriteLine("Nenhum produto cadastrado.");
                    }
                    else
                    {
                        for (int i = 0; i < nomes.Count; i++)
                        {
                            Console.WriteLine($"Nome: {nomes[i]} | Valor: {valores[i]} | Autor: {autores[i]} | Gênero: {generos[i]}");
                        }
                    }
                    Console.WriteLine();
                    break;
                case 3:
                    Console.WriteLine("Opção 3 selecionada.");
                    break;
                case 4:
                    Console.WriteLine("Opção 4 selecionada.");
                    break;
                case 5:
                    Console.WriteLine("Opção 5 selecionada.");
                    break;
                default:
                    Console.WriteLine("Opção inválida.");
                    break;
            }
            
            Console.WriteLine(); // Linha em branco para separação
        }
        
        Console.WriteLine("Saindo do programa...");
    }
}