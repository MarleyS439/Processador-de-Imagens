#!/bin/bash 

# Declarações iniciais
printf "\e[34mIniciando o Script de Processamento de Imagens\n\e[0m"

# Armazena o nome do usuário para uso na variável PATH
userDir=$(whoami)

# Imprime o nome do usuário
echo "O usuário é: $userDir"
echo "Navegando até /home/$userDir/Documentos/Vistorias"

# Navegar ao diretório raiz
cd "/home/$userDir/Documentos/Vistorias/"

# Função para processar as imagens
function process_images {
    # Listar todas as pastas
    printf "\e[38;5;214mLista de diretórios\e[0m\n"
    qnt_diretorios=($(find . -maxdepth 1 -type d -printf "%P\n"))

    # Imprimir a lista de pastas
    for i in "${!qnt_diretorios[@]}"; do
        echo "$i - ${qnt_diretorios[$i]}"
    done

    # Solicitar a seleção da pasta para processamento
    read -p "Digite o número da pasta desejada para processar as imagens: " escolha

    # Verificar se a escolha é válida e entrar na pasta escolhida
    if ((escolha >= 0 && escolha < ${#qnt_diretorios[@]})); then
        pasta_escolhida="${qnt_diretorios[escolha]}"
        cd "$pasta_escolhida"
        echo "Entrando no diretório $pasta_escolhida"

        # Organizar imagens em lotes de 32
        quantidade_arquivos=$(find . -maxdepth 1 -type f -name "*.jpg" | wc -l)
        tamanho_lote=32
        quantidade_pastas=$((quantidade_arquivos / tamanho_lote))

        if ((quantidade_arquivos % tamanho_lote != 0)); then
            quantidade_pastas=$((quantidade_pastas + 1))
        fi

        contador=0

        # Criar pastas para organizar os arquivos
        for ((i = 1; i <= quantidade_pastas; i++)); do
            mkdir -p "$i"
        done

        # Organizar os arquivos em pastas
        printf "\e[33mOrganizando...\e[0m\n"

        # Renomear os arquivos de imagem para que estejam na ordem desejada
        contador=1

        for arquivo in *.jpg; do
            novo_nome="foto_$contador.jpg"
            mv "$arquivo" "$novo_nome"
            contador=$((contador + 1))
        done

        # Mover os arquivos renomeados para as pastas em lotes de 32
        tamanho_lote=32
        quantidade_arquivos=$(ls -1 *.jpg | wc -l)
        quantidade_pastas=$((quantidade_arquivos / tamanho_lote))

        if ((quantidade_arquivos % tamanho_lote != 0)); then
            quantidade_pastas=$((quantidade_pastas + 1))
        fi

        contador=1

        for ((i = 1; i <= quantidade_pastas; i++)); do
            pasta_destino="$i"

            for ((j = 1; j <= tamanho_lote; j++)); do

                if [ $contador -le $quantidade_arquivos ]; then
                    mv "foto_$contador.jpg" "$pasta_destino/"
                    contador=$((contador + 1))
                fi
            done
        done

        printf "\e[33mProcessando imagens...\e[0m\n"

        # Processar as imagens em cada pasta
        for ((i=1; i<=quantidade_pastas; i++)); do
            echo "Processando arquivos da pasta $i"

            cd "$i"

            mogrify -resize 400x300 *.jpg

            nome_arquivo_saida="Fotos_$i.pdf"

            montage -tile 2x4 -geometry +5+5 -border 8x8 -bordercolor white *.jpg "$nome_arquivo_saida"

            gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -dColorImageResolution=100 -sOutputFile="$i.pdf" "$nome_arquivo_saida"

            mv "$i.pdf" "/home/$userDir/Documentos/Vistorias/$pasta_escolhida/"
            cd ..
        done

        # Lista todos os arquivos PDF na pasta em ordem numérica
        pdf_files=$(ls -1v *.pdf)

        # Une os PDFs
        pdfunite $pdf_files "Fotos.pdf"

        printf "\e[33mO arquivo Fotos.pdf foi criado com sucesso.\e[0m\n"

        read -p "Deseja abrir o arquivo? (y/n)" abrirArquivo

        if [[ $abrirArquivo == "y" ]]; then
            xdg-open "Fotos.pdf"

        else
            echo "Saindo..."

        fi

    else
        echo "Escolha inválida."
    fi
}

# Chamar a função para processar as imagens
process_images

printf "\e[32mProcessamento concluído com sucesso!\n\e[0m"
