# encoding: utf-8
import os
import shutil
import datetime
import zipfile

#=== PARAMETROS ========================================================================================
# Lista de UFs do Brasil
list_uf = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
]

# Dicionário de diretórios por tipo de arquivo
dict_diretorio = {
    '.csv': 'C/Users/mical/Documents/POSENGDADOS/REPOSITORIO/ESTRUTURA_DADOS',
    '.zip': 'C:/Users/mical/Documents/POSENGDADOS/ARQUIVOS/ESTRUTURA_DADOS',
    '.pdf': 'C:/Users/mical/Documents/POSENGDADOS/REPOSITORIO/ESTRUTURA_DADOS',
    'outros': 'C:/Users/mical/Documents/POSENGDADOS/REPOSITORIO/ESTRUTURA_DADOS/OUTROS'
}

# Função para gravar logs em log.txt
def gravar_log(mensagem, diretorio_log):
    with open(os.path.join(diretorio_log, 'log-06.txt'), 'a') as log_file:
        log_file.write(mensagem + '\n')

# Arquivos de download
arquivos = dict_diretorio['.zip']

# Repositorio de extracao
repositorio = dict_diretorio['.csv']

# Repositorio para "outros" arquivos
outros = dict_diretorio['outros']

#=== MAIN ==============================================================================================
# Função principal
def main():
    mensagem = "Principal - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
    print(mensagem)
    gravar_log(mensagem, arquivos)

    # 1 - Limpar repositorio
    limpar_diretorio(repositorio, arquivos)
    # 2 - Descompactar os arquivos
    descompactar_arquivos(repositorio, arquivos)
    # 3 - Mover arquivos CSV
    mover_csv(repositorio, arquivos, outros)
    # 4 - Mover arquivos PDF
    mover_pdf(repositorio, arquivos)
    # 5 - Excluir pastas vazias
    excluir_pastas_vazias(repositorio, arquivos)

    mensagem = "Principal - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
    print(mensagem)
    gravar_log(mensagem, arquivos)

#=== SUB FUNCOES =======================================================================================
# Função para mover arquivos csv
def mover_csv(repositorio, arquivos, outros):
    try:
        mensagem = "Função: mover_csv - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)
        
        for root, dirs, files in os.walk(repositorio):

            for file in files:
                extensao = os.path.splitext(file)[1]

                if extensao in dict_diretorio:
                    caminho_atual = os.path.join(root, file)

                    if extensao == '.csv':
                        uf = file.split('_')[-1].replace(extensao, '')  # Extrai a UF do nome do arquivo
                    
                        # Valida se a UF está na lista de UFs
                        if uf in list_uf:
                            # Cria o diretório da UF se não existir
                            diretorio_uf = os.path.join(dict_diretorio[extensao], uf)

                            if not os.path.exists(diretorio_uf):
                                os.makedirs(diretorio_uf)
                                mensagem = f'Diretório {diretorio_uf} criado'
                                print(mensagem)
                                gravar_log(mensagem, arquivos)
                        else:
                            # Atualiza a lista de UFs e o dicionário de diretórios para incluir "Outros"
                            if 'Outros' not in list_uf:
                                list_uf.append('Outros')
                            if 'Outros' not in dict_diretorio:
                                dict_diretorio['Outros'] = outros

                            diretorio_uf = os.path.join(dict_diretorio['Outros'], uf)

                            if not os.path.exists(diretorio_uf):
                                os.makedirs(diretorio_uf)
                                mensagem = f'Diretório {diretorio_uf} criado para arquivos não classificados'
                                print(mensagem)
                                gravar_log(mensagem, arquivos)

                        caminho_destino = os.path.join(diretorio_uf, file)
                        
                        # Move arquivos
                        shutil.move(caminho_atual, caminho_destino)
                        mensagem = f'Movido {caminho_atual} para {caminho_destino}'
                        print(mensagem)
                        gravar_log(mensagem, arquivos)
        
        mensagem = "Função: mover_csv - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

    except Exception as e:
        mensagem = 'Erro ao mover_csv: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, arquivos)
        raise e
        
# Funcão para mover arquivos pdf
def mover_pdf(repositorio, arquivos):
    try:
        mensagem = "Função: mover_pdf - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

        for root, dirs, files in os.walk(repositorio):

            # Remover "Outros" de dirs para que os subdiretórios não sejam percorridos
            dirs[:] = [d for d in dirs if d != 'OUTROS']

            # Garantir que a pasta "Outros" seja ignorada
            if 'OUTROS' in root:
                continue

            for file in files:
                extensao = os.path.splitext(file)[1]
                
                if extensao in dict_diretorio:
                    caminho_atual = os.path.join(root, file)

                    # Renomeia e move PDFs
                    if extensao == '.pdf':
                        nome_pasta = os.path.basename(os.path.dirname(caminho_atual))
                        novo_nome_pdf = f'{os.path.splitext(file)[0]}_{nome_pasta}.pdf'
                        caminho_novo_pdf = os.path.join(dict_diretorio['Outros'], novo_nome_pdf)
                        os.rename(caminho_atual, caminho_novo_pdf)
                        mensagem = f'Renomeado e movido {caminho_atual} para {caminho_novo_pdf}'
                        print(mensagem)
                        gravar_log(mensagem, arquivos)

        mensagem = "Função: mover_pdf - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

    except Exception as e:
        mensagem = 'Erro ao mover_pdf: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, arquivos)
        raise e

# Função para descompactar arquivos
def descompactar_arquivos(repositorio, arquivos):
    try:
        mensagem = "Função: descompactar_arquivos - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

        for root, dirs, files in os.walk(arquivos):

            for file in files:

                if file.endswith('.zip'):
                    zip = os.path.join(root, file)
                    extracao = os.path.splitext(file)[0]
                    extraidos = os.path.join(repositorio, extracao)

                    with zipfile.ZipFile(zip, 'r') as zip_ref:
                        zip_ref.extractall(extraidos)
                        print(f'Descompactado {zip} para {extraidos}')
                        gravar_log(f'Descompactado {zip} para {extraidos}', arquivos)

        mensagem = "Função: descompactar_arquivos - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

    except Exception as e:
        mensagem = 'Erro ao descompactar_arquivos: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, arquivos)
        raise e

# Função para excluir pastas vazias
def excluir_pastas_vazias(repositorio, arquivos):
    try:
        mensagem = "Função: excluir_pastas_vazias - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)
        
        for root, dirs, files in os.walk(repositorio, topdown=False):

            for dir in dirs:
                caminho_diretorio = os.path.join(root, dir)
                print(f'Verificando diretório: {caminho_diretorio}')
                gravar_log(caminho_diretorio, arquivos)

                if not os.listdir(caminho_diretorio):  # Verifica se a pasta está vazia
                    os.rmdir(caminho_diretorio)
                    mensagem = f'Pasta vazia {caminho_diretorio} excluída'
                    print(mensagem)
                    gravar_log(mensagem, arquivos)
        
        mensagem = "Função: excluir_pastas_vazias - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, arquivos)

    except Exception as e:
        mensagem = 'Erro ao excluir_pastas_vazias: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, arquivos)
        raise e

def limpar_diretorio(repositorio, arquivos):
    try:
        for root, dirs, files in os.walk(repositorio, topdown=False):
            for file in files:
                caminho_arquivo = os.path.join(root, file)
                os.remove(caminho_arquivo)
                print(f'Arquivo {caminho_arquivo} excluído')
                
            for dir in dirs:
                caminho_diretorio = os.path.join(root, dir)
                os.rmdir(caminho_diretorio)
                print(f'Diretório {caminho_diretorio} excluído')
        
        print(f'Diretório {repositorio} limpo')

    except Exception as e:
        mensagem = 'Erro ao limpar_diretorio: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, arquivos)
        raise e


#=== END ===============================================================================================
# Execução do main
if __name__ == "__main__":
    main()