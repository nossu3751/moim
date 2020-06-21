import 'package:flutter/material.dart';

class Article {
  String _ownerID;
  String _title;
  String _text;
  int _likes;

  Article(this._ownerID ,this._title, this._text, this._likes);

  getOwnerID() => this._ownerID;
  getTitle() => this._title;
  getText() => this._text;
  getLike() => this._likes;
}