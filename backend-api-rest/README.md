<h1> API REST do aplicativo de gerenciamento de projetos! </h1>

## 🤔 Como executar

<p>
Para realizar a execução do projeto é bem simples. Como já mencionado, este possui integração com o banco de dados MySQL, portanto, é importante que você verifique se todas as configurações de usuário e senha para acessar o banco estejam corretas, você pode fazer isso através do arquivo de propriedades que fica no resources do projeto, como mostra a imagem: <br>
  
<p align="center"> 
  <img src="https://user-images.githubusercontent.com/45599504/77165933-0b905800-6a92-11ea-8ad9-b90d1f8d3808.png" width=300> 
</p> <br>

Após isso, não é necessário criar um banco de dados com o nome que está no projeto. Apenas certifique-se de que as configurações de acesso ao banco de dados estão corretas, isso inclui URL para o banco, Porta (se for necessário), Usuário e Senha. Após se certificar, o projeto irá se encarregar de criar o banco e montar seu esquema, pois, como já mencionado, o projeto já conta com uma tecnologia de migração de banco de dados o Flyway.
</p>

<p>
Após ter feito essa pequena verificação de configuração, você pode dá um start no projeto, para isso, se você estiver em uma IDE, basta executar a classe <strong>GerenciadorDeProjetosApiApplication</strong> na raiz do projeto! Se você ainda não tiver baixado as dependências, assim que você executar, provavelmente o projeto se encarregarar de baixar. Pode demorar um pouco para executar, pois, ele deverá baixar as dependências e realizar a migração do banco.  
</p>

<p>
Se tudo der certo, você verá essa uma saída parecida com essa no seu console: <br>
  
  <p align="center"> 
    <img src="https://user-images.githubusercontent.com/45599504/77166717-85751100-6a93-11ea-90e4-d6145604d1f1.png" width=100%> 
  </p><br>

</p>
