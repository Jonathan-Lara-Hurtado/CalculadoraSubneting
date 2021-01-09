/*
return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('De'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: 160.0,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      Radio(value: 'd', groupValue: 'd', onChanged: (v) {}),
                      Text('Decimal'),
                    ],
                  ),
                ),
                Container(
                  width: 160.0,
                  // color: Colors.blue,
                  child: Row(
                    children: [
                      Radio(value: 'h', groupValue: '', onChanged: (v) {}),
                      Text('Hexadecimal'),
                    ],
                  ),
                ),
                Container(
                  width: 160.0,
                  //color: Colors.green,
                  child: Row(
                    children: [
                      Radio(value: '', groupValue: '', onChanged: (v) {}),
                      Text('Binario'),
                    ],
                  ),
                ),
                Container(
                  width: 160.0,
                  //color: Colors.yellow,
                  child: Row(
                    children: [
                      Radio(value: '', groupValue: 'gass', onChanged: (v) {}),
                      Text('Octal'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    
    */
