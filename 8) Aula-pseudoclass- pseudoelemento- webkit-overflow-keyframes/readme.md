
## Pseudo classes

 - trabalha o estado de um elemento e elementos filhos
 - é inserida com : 
  
 - exemplos: `:hover`
             `:first-child`
             `:last-child`
             `:nth-child()`

 - observação: junto com a pseudo classe `:hover` utilizamos a propriedade `transition` para criar uma transição


**transition**


`Como usar transições CSS?`

Para criar um efeito de transição, você deve especificar duas coisas:

 - a propriedade CSS à qual você deseja adicionar um efeito
 - a duração do efeito
 - Nota: Se a parte da duração não for especificada, a transição não terá efeito, pois o valor padrão é 0.


`Alguns Valores de transição`


`ease`- especifica um efeito de transição com um início lento, depois rápido e depois termina lentamente (este é o padrão)

`linear`- especifica um efeito de transição com a mesma velocidade do início ao fim

`ease-in`- especifica um efeito de transição com um início lento

`ease-out`- especifica um efeito de transição com um final lento

`ease-in-out`- especifica um efeito de transição com início e fim lentos

`cubic-bezier(n,n,n,n)`- permite definir seus próprios valores em uma função cúbica-bezier




## Pseudo elementos

 - trabalha com o elemento
 - é inserido com ::

 - exemplos: ` ::before `
             ` ::after  `

- observação: tambem podemos utilizar para alcançar um elemento que não está acessivel no Html como: scrollbar e selection.




## overflow

A propriedade `overflow` especifica quando o conteúdo de um elemento de nível de bloco deve ser cortado, exibido com barras de rolagem ou se transborda do elemento

aplicação: overflow: auto



## Prefixos de navegadores.

Por existirem muitos navegadores, e cada um com sua especificação, é necessário adicionar esses prefixos para que um estilo CSS funcione em todos.

`-webkit-`
(Chrome, Safari, versões mais recentes do Opera.)

`-moz-`
(Firefox)

`-ms-`
(Internet Explorer)




## Keyframes

A regra `@keyframes` vai definir as etapas da sua animação. Com ela você vai informar o início e o final do valor da propriedade CSS que você deseja animar.

Vale lembrar a animação acontece na transição de um valor para o outro. Exemplo, na transição de `100px` de width para `200px` de width. Ou na transição do `red` para o `blue` (no caso de cores).

uma propriedade bastante utilizada para criar animações é o `transform:`

exemplos:


@keyframes estica {
  from{
   width: 100px;
 }
 to{
   width: 200px;
 }
}


@keyframes estica {
 0% {
   width: 100px;
 }
 100% {
   width: 200px;
 }
}


@keyframes sinal {
 0% {
   background: red;
 }
 25% {
   background: yellow;
 }
 50% {
   background: green;
 }
 75% {
   background: yellow;
 }
 100% {
   background: red;
 }
}


**transform**

`Definição e uso`
A transform propriedade aplica uma transformação 2D ou 3D a um elemento. Esta propriedade permite girar, dimensionar, mover, inclinar, etc., elementos.

## Valores:

`scale():` afeta o tamanho do elemento. Isso também se aplica ao font-size, padding, heighte widthde um elemento também. É também uma função abreviada para as funções scaleXe scaleY.

`skewX()`e skewY(): inclina um elemento para a esquerda ou direita, como transformar um retângulo em um paralelogramo. skew()é uma abreviação que combina skewX()e skewY aceitando ambos os valores.

`translate():` Move um elemento para os lados ou para cima e para baixo.

`rotate():` Gira o elemento no sentido horário a partir de sua posição atual.

`matrix():` uma função que provavelmente não deve ser escrita à mão, mas combina todas as transformações em uma.

`perspective():` não afeta o elemento em si, mas afeta as transformações das transformações 3D dos elementos descendentes, permitindo que todos tenham uma perspectiva de profundidade consistente.


## Media Queries (Responsivo)

/* Tamanhos muito pequenos de tela (celulares, 600px pra baixo) */
`@media only screen and (max-width: 600px) {...}`

/* Tamanho pequeno de tela (tablets portatil e celulares mais largos, 600px pra cima) */
`@media only screen and (min-width: 600px) {...}`

/* Tamanho mediano de tela (tablets, 768px para cima) */
`@media only screen and (min-width: 768px) {...}`

/* Tamanho grande de tela (notebooks e monitores, 992px para cima) */
`@media only screen and (min-width: 992px) {...}`

/* Tamanhos muito grande de tela (notebooks grandes e monitores e televisão, 1200px para cima) */
`@media only screen and (min-width: 1200px) {...}`