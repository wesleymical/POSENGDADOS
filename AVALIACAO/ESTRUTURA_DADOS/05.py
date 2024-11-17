# encoding: utf-8
import os
import shutil
import datetime

#=== PARAMETROS ========================================================================================
# Lista de UFs do Brasil
list_uf = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
]

# Dicionário de diretórios por tipo de arquivo
dict_diretorio = {
    '.csv': 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/ATIVIDADE',
    '.zip': 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/ARQUIVOS',
    '.pdf': 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/ATIVIDADE'
}

# Função para gravar logs em .txt
def gravar_log(mensagem, diretorio_log):
    with open(os.path.join(diretorio_log, 'log-05.txt'), 'a') as log_file:
        log_file.write(mensagem + '\n')

#=== MAIN ==============================================================================================
# Função principal
def main():
    download = 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/Download'
    mensagem = "Principal - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
    print(mensagem)
    gravar_log(mensagem, download)
    
    mover_arquivos(download)
    
    mensagem = "Principal - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
    print(mensagem)
    gravar_log(mensagem, download)

#=== SUB FUNCOES =======================================================================================
# Função para mover e renomear arquivos com base na extensão da dict
def mover_arquivos(diretorio_origem):
    try:
        mensagem = "Função: mover_arquivos - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        
        for root, dirs, files in os.walk(diretorio_origem):
            for file in files:
                extensao = os.path.splitext(file)[1]
                if extensao in dict_diretorio:
                    caminho_atual = os.path.join(root, file)
                    uf = file.split('_')[-1].replace(extensao, '')  # Extrai a UF do nome do arquivo
                    
                    # Valida se a UF está na lista de UFs
                    if uf in list_uf:
                        # Cria o diretório da UF se não existir
                        diretorio_uf = os.path.join(dict_diretorio[extensao], uf)
                        if not os.path.exists(diretorio_uf):
                            os.makedirs(diretorio_uf)
                            mensagem = f'Diretório {diretorio_uf} criado'
                            print(mensagem)
                            gravar_log(mensagem, diretorio_origem)
                        
                        caminho_destino = os.path.join(diretorio_uf, file)
                        
                        # Renomeia e move PDFs
                        if extensao == '.pdf':
                            nome_pasta = os.path.basename(os.path.dirname(caminho_atual))
                            novo_nome_pdf = f'{os.path.splitext(file)[0]}_leia-me_{nome_pasta}.pdf'
                            caminho_novo_pdf = os.path.join(diretorio_uf, novo_nome_pdf)
                            os.rename(caminho_atual, caminho_novo_pdf)
                            mensagem = f'Renomeado e movido {caminho_atual} para {caminho_novo_pdf}'
                            print(mensagem)
                            gravar_log(mensagem, diretorio_origem)
                        else:
                            # Move demais arquivos
                            shutil.move(caminho_atual, caminho_destino)
                            mensagem = f'Movido {caminho_atual} para {caminho_destino}'
                            print(mensagem)
                            gravar_log(mensagem, diretorio_origem)
                    else:
                        mensagem = f'UF {uf} não encontrada na lista de UFs'
                        print(mensagem)
                        gravar_log(mensagem, diretorio_origem)
                        
        mensagem = "Função: mover_arquivos - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
    except Exception as e:
        mensagem = 'Erro ao processar mover_arquivos: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        raise e

#=== END ===============================================================================================
# Execução do main
if __name__ == "__main__":
    main()