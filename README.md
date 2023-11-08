# Script de Processamento de Imagens

## Uso

1. Este script em Bash (`process_images.sh`) é para uso no terminal bash de Linux

2. O script iniciará e navegará até o diretório /home/<seu_usuário>/Documentos/Vistorias/, onde estão localizadas as pastas com as imagens a serem processadas.

**Observações:**
 Você pode usar o comando `cd Documentos/ && mkdir Vistorias` para criar o diretório para colocar as imagens para processar.

3. O script listará os diretórios disponíveis e permitirá que você escolha a pasta para processar as imagens. Basta digitar o número correspondente à pasta desejada.

4. O script organizará as imagens em lotes de 32, renomeando-as com quatro dígitos à esquerda, por exemplo, "foto_0001.jpg", "foto_0002.jpg", etc. As imagens renomeadas serão divididas em pastas de acordo com o tamanho do lote, e em cada pasta, as imagens serão redimensionadas para 400x300 pixels. Os lotes são de 32 por contada otimização do processamentos dos arquivos. 32 é uma quantidade suficiente para manter o desempenho e qualidade do processamento das imagens.

5. Um arquivo PDF será gerado para cada pasta contendo as imagens redimensionadas.

6. Os arquivos PDF resultantes serão unidos em um único arquivo chamado "Fotos.pdf".

7. Você terá a opção de abrir o arquivo "Fotos.pdf" após o processamento.

## Pré-requisitos

- Sistema operacional Linux (OpenSUSE, Ubuntu, Debian, Fedora)

- Utilitários mogrify, montage, e gs (Ghostscript) instalados.

## Dependências

### Para utilizar este script de processamento de imagens, você precisará das seguintes dependências:

- **Bash:** O script é escrito em Bash. Obviamente, você deve tê-lo.

- **mogrify (ImageMagick):** O utilitário "mogrify" faz parte do pacote ImageMagick e é usado para redimensionar as imagens.

- **montage (ImageMagick):** O comando "montage" também faz parte do pacote ImageMagick e é usado para criar montagens de imagens no processo. Portanto, o ImageMagick é necessário para utilizar o "montage".

- **Ghostscript (gs):** O Ghostscript é uma linguagem de descrição de página para impressoras e é usado para converter as montagens de imagens em arquivos PDF.

Você pode verificar se essas ferramentas estão instaladas no sistema executando os comandos:

`mogrify -version`
`montage -version`
`gs --version`

Se algum desses comandos não for reconhecido, você precisará instalá-los no sistema. Isso pode variar dependendo da distribuição Linux que você está usando. Por exemplo, em sistemas baseados no Debian (como o Ubuntu), você pode instalá-los com o comando `sudo apt-get install imagemagick ghostscript`.

## Personalização

Você pode ajustar o código do script para atender às suas necessidades específicas. Por exemplo, você pode modificar os tamanhos de redimensionamento das imagens, a quantidade de imagens por lote, entre outras configurações.

## Contribuição

Se você encontrar problemas ou desejar contribuir com melhorias no script, sinta-se à vontade para abrir uma issue ou enviar uma solicitação de pull.

## Licença

Este script é disponibilizado sob a licença MIT. Consulte o arquivo [LICENSE](https://github.com/MarleyS439/Processador-de-Imagens/blob/main/LICENSE) para obter mais detalhes.

**Autor**

Marley Santos
E-mail: [marleysantos439@gmail.com](mailto:marleysantos439@gmail.com)

GitHub: [MarleyS439](https://github.com/MarleyS439/)

Instagram: [@marleysantos4390](instagram.com/marleysantos4390)

LinkedIn: [Marley Santos](https://www.linkedin.com/in/marleysantos/)
