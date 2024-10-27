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

# Função para gravar logs em log.txt
def gravar_log(mensagem, diretorio_log):
    with open(os.path.join(diretorio_log, 'log-06.txt'), 'a') as log_file:
        log_file.write(mensagem + '\n')

#=== MAIN ==============================================================================================
# Função principal
def main():
    download = 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/Download'
    mensagem = "Principal - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
    print(mensagem)
    gravar_log(mensagem, download)
    
    mover_arquivos(download)
    mover_restantes_para_outros(download)
    excluir_pastas_vazias(download)
    
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
                    else:
                        # Atualiza a lista de UFs e o dicionário de diretórios para incluir "Outro"
                        if 'Outros' not in list_uf:
                            list_uf.append('Outros')
                        if 'Outros' not in dict_diretorio:
                            dict_diretorio['Outros'] = 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/ATIVIDADE/OUTROS'
                        
                        diretorio_uf = os.path.join(dict_diretorio['Outros'], uf)
                        if not os.path.exists(diretorio_uf):
                            os.makedirs(diretorio_uf)
                            mensagem = f'Diretório {diretorio_uf} criado para arquivos não classificados'
                            print(mensagem)
                            gravar_log(mensagem, diretorio_origem)
                        
                    caminho_destino = os.path.join(diretorio_uf, file)
                    
                    # Renomeia e move PDFs
                    if extensao == '.pdf':
                        nome_pasta = os.path.basename(os.path.dirname(caminho_atual))
                        novo_nome_pdf = f'{os.path.splitext(file)[0]}_{nome_pasta}.pdf'
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
        
        mensagem = "Função: mover_arquivos - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
    except Exception as e:
        mensagem = 'Erro ao processar mover_arquivos: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        raise e

# Função para excluir pastas vazias
def excluir_pastas_vazias(diretorio_origem):
    try:
        mensagem = "Função: excluir_pastas_vazias - Inicio - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        
        for root, dirs, files in os.walk(diretorio_origem, topdown=False):
            for dir in dirs:
                caminho_diretorio = os.path.join(root, dir)
                if not os.listdir(caminho_diretorio):  # Verifica se a pasta está vazia
                    os.rmdir(caminho_diretorio)
                    mensagem = f'Pasta vazia {caminho_diretorio} excluída'
                    print(mensagem)
                    gravar_log(mensagem, diretorio_origem)
        
        mensagem = "Função: excluir_pastas_vazias - Fim - " + str(datetime.datetime.now().strftime("%H:%M:%S"))
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
    except Exception as e:
        mensagem = 'Erro ao processar excluir_pastas_vazias: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        raise e

# Função para mover arquivos restantes para o diretório "Outro"
def mover_restantes_para_outros(diretorio_origem):
    try:
        outro_diretorio = dict_diretorio['Outros']
        if not os.path.exists(outro_diretorio):
            os.makedirs(outro_diretorio)
            mensagem = f'Diretório {outro_diretorio} criado'
            print(mensagem)
            gravar_log(mensagem, diretorio_origem)
        
        for root, dirs, files in os.walk(diretorio_origem):
            for file in files:
                caminho_atual = os.path.join(root, file)
                caminho_destino = os.path.join(outro_diretorio, file)
                shutil.move(caminho_atual, caminho_destino)
                mensagem = f'Movido {caminho_atual} para {caminho_destino}'
                print(mensagem)
                gravar_log(mensagem, diretorio_origem)
    except Exception as e:
        mensagem = 'Erro ao processar mover_restantes_para_outros: ' + str(e)
        print(mensagem)
        gravar_log(mensagem, diretorio_origem)
        raise e

#=== END ===============================================================================================
# Execução do main
if __name__ == "__main__":
    main()