# Data Warehouse – Arquitetura Medallion  
## Viagens Oficiais do Governo Federal Brasileiro

Este repositório contém o desenvolvimento de um projeto de Data Warehouse baseado na arquitetura Medallion, utilizando como base de dados os dados públicos de viagens oficiais do Governo Federal, obtidos a partir do [Portal da Transparência](https://portaldatransparencia.gov.br/viagens/consulta?ordenarPor=de&direcao=desc).

Objetivando disponibilizar uma base de dados confiável e organizada que permita a análise de gastos públicos com viagens oficiais, visualização por órgão, destino e período, apoio à transparência e à tomada de decisão e demonstração prática da aplicação da arquitetura Medallion em dados governamentais.

O trabalho está alinhado à disciplina **Banco de Dados 2 – Universidade de Brasília (UnB)** e aplica conceitos de engenharia de dados, arquitetura de dados e modelagem dimensional.

## Estrutura do Repositório

```text
bd2-gov-viagens-medallion-bi/
 ├── Data_Layer/
 │   ├── raw/        # Dados originais (Bronze)
 │   ├── silver/     # Dados limpos, tipados e padronizados
 │   ├── gold/       # Dados modelados para BI (modelo dimensional)
 │   └── README.md
 └── Transformer/    # Scripts de ETL e transformações
```

## Camadas da Arquitetura Medallion

**RAW**  
- Contém os dados originais exatamente como coletados  
- Arquivo CSV baixado diretamente do Portal da Transparência  
- Nenhuma modificação estrutural ou semântica  
- Preserva a integridade e rastreabilidade da fonte  

**Silver**  
- Dados tratados e padronizados  
- Correção de tipos (datas, valores monetários, identificadores)  
- Tratamento de inconsistências, valores ausentes e formatação  
- Preparação para integração e modelagem analítica  

**Gold**  
- Dados modelados para análise  
- Estrutura em modelo dimensional (esquema estrela)  
- Separação entre:  
  - Tabelas fato 
  - Tabelas dimensão  
- Base pronta para consumo em Power BI  

## Como rodar o projeto
Primeiro na pasta root do projeto podemos rodar o comando:

docker compose up --build

Depois que o comando terminar podemos rodar basta acessar o link localhost: 

http://127.0.0.1:8888/tree

## Desenvolvedores

[Davi Gonçalves Akegawa Pierre](https://github.com/DaviPierre)  
[Julia Gabriela Cunha Paulino](https://github.com/JuliaGabP)
