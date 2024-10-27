import os
import zipfile

def extrair(zip_dir):
    for root, dirs, files in os.walk(zip_dir):
        for file in files:
            if file.endswith('.zip'):
                caminho_zip = os.path.join(root, file)
                nome_pasta = os.path.splitext(file)[0]
                caminho_extrair = os.path.join(root, nome_pasta)

                # Criar a pasta da extração
                if not os.path.exists(caminho_extrair):
                    os.makedirs(caminho_extrair)

                with zipfile.ZipFile(caminho_zip, 'r') as zip_ref:
                    zip_ref.extractall(caminho_extrair)
                    print(f'Descompactado {caminho_zip} para {caminho_extrair}')

# Diretório dos arquivos zipados
zip = 'D:/mical/Documents/POS ENGENHARIA DE DADOS/MATERIAS/ED/Download'

# Extração
extrair(zip)