import csv
import os

# Definindo os caminhos dos diretórios
posengdados = os.path.join('D:\mical\Documents\POS ENGENHARIA DE DADOS\POSENGDADOS')
repositorio = os.path.join(posengdados, 'REPOSITORIO')
sql_engines = os.path.join(repositorio, 'SQL_ENGINES')
repositorio_pastas = os.listdir(sql_engines)

# Dicionário de diretórios
dict_diretorio = {
    'CANDIDATO': repositorio_pastas[1],
    'BEM_CANDIDATO': repositorio_pastas[0],
    'REDE_SOCIAL': repositorio_pastas[2],
    'VOTACAO': repositorio_pastas[3]
}

# Nomes dos arquivos
files_bem_candidato = 'bem_candidato_2024_AC.csv'
files_redes = 'rede_social_candidato_2024_AC.csv'
files_votacao = 'votacao_candidato_munzona_2024_AC.csv'

def main():
    # Caminhos completos dos arquivos
    caminho_arquivo_bem = os.path.join(sql_engines, dict_diretorio['BEM_CANDIDATO'], files_bem_candidato)
    caminho_arquivo_redes = os.path.join(sql_engines, dict_diretorio['REDE_SOCIAL'], files_redes)
    caminho_arquivo_votacao = os.path.join(sql_engines, dict_diretorio['VOTACAO'], files_votacao)

    # Ler os cabeçalhos e a segunda linha dos arquivos
    cabecalho_bem_candidato, dados_bem_candidato = ler_cabecalho_e_dados_csv(caminho_arquivo_bem)
    cabecalho_redes_sociais, dados_redes_sociais = ler_cabecalho_e_dados_csv(caminho_arquivo_redes)
    cabecalho_relacao_candidatos_area, dados_relacao_candidatos_area = ler_cabecalho_e_dados_csv(caminho_arquivo_votacao)

    # Imprimir os cabeçalhos e a segunda linha
    print("Cabeçalho Bens dos Candidatos:", cabecalho_bem_candidato)
    print(dados_bem_candidato)
    #print("Cabeçalho Redes Sociais:", cabecalho_redes_sociais)
    #print("Dados Redes Sociais:", dados_redes_sociais)
    #print("Cabeçalho Relação Candidatos x Área de Votação:", cabecalho_relacao_candidatos_area)
    #print("Dados Relação Candidatos x Área de Votação:", dados_relacao_candidatos_area)

# Função para ler o cabeçalho e a segunda linha de um arquivo CSV
def ler_cabecalho_e_dados_csv(param):
    with open(param, mode='r', encoding='Latin-1') as arquivo_csv:
        leitor_csv = csv.reader(arquivo_csv)
        cabecalho = next(leitor_csv)
        dados = next(leitor_csv)
    return cabecalho, dados

# Execução do main
if __name__ == "__main__":
    main()