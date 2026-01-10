# Camada Raw (Bronze)

Esta pasta corresponde à Camada Raw (Bronze) da arquitetura Medallion, utilizada no projeto de Data Warehouse sobre Viagens Oficiais de Servidores do Governo Federal Brasileiro.  

A camada Raw tem como finalidade armazenar os dados brutos, exatamente como foram obtidos da fonte original, sem qualquer tipo de tratamento, transformação ou padronização, garantindo a integridade, rastreabilidade e reprodutibilidade dos dados.  

## Fonte dos Dados

Os dados foram extraídos do Portal da Transparência do Governo Federal, por meio da funcionalidade de exportação em formato CSV, disponível na seção de Viagens à Serviço.

- Fonte: Portal da Transparência;  
- Formato original: CSV;  
- Tipo de dados: Dados públicos governamentais;  
- Conteúdo: Informações sobre concessão de diárias e passagens (PCDP).

## Conteúdo da Pasta

Esta pasta pode contém:
- Arquivo .csv original baixado diretamente do portal;
- Arquivo .ipynb com gráficos e análises geradas a partir do arquivo .csv;
- Arquivo do Dicionário de dados servindo de guia para maior entendimento do projeto.

## Observações Importantes

- Os dados nesta camada não foram alterados, apenas analisados;
- Não há correção de tipos, limpeza ou validação;
- Valores inconsistentes, nulos ou fora do padrão são mantidos;
- Transformações ocorreram exclusivamente na camada Silver.

## Objetivo da Camada Raw

- Preservar os dados conforme fonte original;  
- Garantir rastreabilidade.  