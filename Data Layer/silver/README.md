# Camada Silver (Prata)

Esta pasta corresponde à Camada Silver (Prata) da arquitetura Medallion, utilizada no projeto de Data Warehouse sobre Viagens Oficiais de Servidores do Governo Federal Brasileiro.

A camada Silver tem como finalidade processar, limpar e padronizar os dados originados da camada Raw, aplicando transformações necessárias para garantir qualidade, consistência e tipagem correta, preparando os dados para a modelagem analítica na camada Gold.

## Fonte dos Dados

Os dados desta camada são derivados exclusivamente da Camada Raw (Bronze), a partir dos arquivos CSV originais extraídos do Portal da Transparência do Governo Federal, sem adição de fontes externas.

- Fonte: Camada Raw;  
- Origem original: Portal da Transparência;  
- Tipo de dados: Dados públicos governamentais tratados;  

## Conteúdo da Pasta

Esta pasta pode contém:
- Arquivo com gráficos gerados à partir dos dados tratados e limpos;
- Arquivo ddl para definição da estrutura do banco;
- Arquivo com o MER e DER contituindo a documentação;

## Transformações Realizadas

Na camada Silver, são aplicadas as seguintes transformações:

- Correção e padronização de tipos de dados; 
- Tratamento de valores nulos e inconsistentes;
- Padronização de campos categóricos;
- Remoção de duplicidades, quando aplicável;
- Normalização de formatos textuais;
- Preparação dos dados para integração e análise;

## Observações Importantes

- Os dados nesta camada já passaram por tratamento;
- Nenhuma agregação analítica final é realizada nesta etapa;
- As transformações são reprodutíveis e documentadas.

## Objetivo da Camada Silver

- Garantir qualidade e consistência dos dados;  
- Aplicar regras de negócio básicas;  
- Preparar os dados para modelagem dimensional.
