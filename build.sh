#!/bin/bash
PARAMETER=$1

# Carrega as variáveis de um arquivo .env
if [[ -f .env ]]; then
    export $(cat .env | xargs)
fi

# Verifica se o Dockerfile existe
if [[ ! -f Dockerfile ]]; then
    echo "O arquivo Dockerfile não foi encontrado."
    exit 1
fi

# Constrói a imagem Docker
docker build -t $USER/$IMAGE:$TAG .

# Verifica se a construção da imagem foi bem-sucedida
if [[ $? -eq 0 ]]; then
    echo "A imagem Docker foi construída com sucesso."

    # Verifica se o parâmetro é "latest"
    if [[ "$PARAMETER" == "latest" ]]; then
        # Tag da imagem Docker
        docker tag $USER/$IMAGE:$TAG $USER/$IMAGE:latest
        echo "A imagem Docker foi marcada com a tag '$IMAGE:$TAG'."

        # Faz o push da imagem Docker
        docker push -a $USER/$IMAGE
        echo "A imagem Docker foi enviada para o registro."
    else
        # Faz o push da imagem Docker com a tag especificada
        docker push $USER/$IMAGE:$TAG
        echo "A imagem Docker foi enviada para o registro com a tag '$TAG'."
    fi
else
    echo "Ocorreu um erro ao construir a imagem Docker."
fi
