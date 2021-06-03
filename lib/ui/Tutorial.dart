import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:myfriend/ui/Home.dart';



class Tutorial extends StatelessWidget {

  final String _textoInicio =
      "Olá, seja bem vindo ao My Friend. Preparamos um tutorial para lhe apresentar as funcionalidades do aplicativo. Na parte inferior da tela há dois botões onde você pode optar por prosseguir com o tutorial ou pular.";

  final String _textoIntroducao =
      "Este aplicativo tem o objetivo de guiar você dentro dos locais my friend. Você conseguirá identificar quais são estes lugares no aplicativo. Utilizando o piso tátil, o aplicativo irá lhe informar "
      "em qual parte do local você se encontra e guiar até os destinos deste local.";

  final String _textoPisoTatil =
      "O piso tátil atenção, representa em qual parte do local você se encontra e está conectado ao piso tátil direcional que irá guiar você até os outros espaços do local. "
      "Há dois tipos de piso tátil atenção, um com somente uma conexão sendo ponto de início ou ponto final do local possuindo somente uma direção e outro tipo de piso tátil atenção que possui três conexões "
      "formando um t, sendo a conexão do meio o caminho para frente e os dois restantes como esquerda e direita.";

  final String _textoMenu =
      "A tela de menu apresenta seis funções, onde estou, descrever espaço, destinos, locais, tutorial e sair. "
      "Essas funções estão divididas em três linhas com dois grandes botões. ";

  final String _textoOndeEstou =
      "Ao clicar no botão onde estou, o aplicativo irá buscar a sua localização dentro de um local my friend e informar em qual espaço você está mais próximo. "
      "Lembrando que um espaço pode ser a entrada do local, uma recepção ou entrada do banheiro. Este espaço sempre será representado por um piso tátil de atenção. ";

  final String _textoDescreverEspaco =
      "Ao clicar no botão descrever espaço, o aplicativo irá descrever as características sobre a sua localização atual. "
      "Podendo ser apresentado informações como o tamanho e como os objetos estão distribuídos. ";

  final String _textoDestinos =
      "Ao clicar no botão destinos, o aplicativo irá apresentar uma lista com os espaços que você pode ir dentro do local, a partir da sua localização atual. "
      "Clicando em um destino o aplicativo irá informar qual quantidade de passos e a direção que você precisa seguir para alcançar o destino selecionado. ";

  final String _textoLocais =
      "Ao clicar no botão locais, o aplicativo irá apresentar a lista de locais my friend. "
      "Ao clicar em um dos locais listados, o aplicativo irá apresentar informações como endereço e telefone deste local. ";

  final String _textoTutorial =
      "Ao clicar no botão tutorial, o aplicativo oferece a possibilidade de rever as informações apresentadas neste tutorial. ";

  final String _textoSair =
      "Ao clicar no botão sair, o aplicativo será encerrado. ";

  PageController _pageviewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Tutorial', style: TextStyle(fontSize: 25.0)),
          centerTitle: true,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageviewController,
          children: [
            _buildStackPageTutorial(context, _textoInicio, true),
            _buildStackPageTutorial(context, _textoIntroducao, false, "Introdução"),
            _buildStackPageTutorial(context, _textoPisoTatil, false, "Piso tátil"),
            _buildStackPageTutorial(context, _textoMenu, false, "Menu"),
            _buildStackPageTutorial(context, _textoOndeEstou, false, "Onde estou?"),
            _buildStackPageTutorial(context, _textoDescreverEspaco, false, "Descrever espaço"),
            _buildStackPageTutorial(context, _textoDestinos, false, "Destinos"),
            _buildStackPageTutorial(context, _textoLocais, false, "Locais"),
            _buildStackPageTutorial(context, _textoTutorial, false,"Tutorial"),
            _buildStackPageTutorial(context, _textoSair, false, "Sair"),
          ],
        ));
  }

  Widget _buildStackPageTutorial(
      BuildContext context, String descricao, bool primeiraTela, [String labelTutorial]) {
    return Stack(

      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  labelTutorial == null ? "" : labelTutorial,
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      descricao,
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        GridView.count(
          padding: EdgeInsets.all(5.0),
          reverse: true,
          crossAxisCount: 2,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FlatButton(
                child: Text(
                  primeiraTela == true ? "Pular Tutorial" : "Anterior",
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  primeiraTela == true ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home())) : {
                    _pageviewController.previousPage(duration:Duration(seconds: 1), curve: Curves.easeOutQuint),
                  };
                },
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FlatButton(
                child: Text(
                  labelTutorial == "Sair" ? "Ir para o MyFriend" : "Próximo",
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  labelTutorial == "Sair" ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home())) : {
                    _pageviewController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeOutQuint),
                  };
                },
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
