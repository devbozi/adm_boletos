import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoletosMenu extends StatelessWidget {
  const BoletosMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black38,
      ),
      child: Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text('Natalinos',
           style: TextStyle(
            fontSize: 20,
            ),
          ),
        ),
        Align(
        alignment: Alignment.bottomLeft,
          child: Text('Vencimento: 25/05/2025',
           style: TextStyle(
            fontSize: 15,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Icon(CupertinoIcons.doc_on_doc,
          size: 25,
          color: Colors.black87,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text('RS: 755,90',
          style: TextStyle(
            fontSize: 18,
          ),),
        )
        
      ],
      ),
    );
  }
}

