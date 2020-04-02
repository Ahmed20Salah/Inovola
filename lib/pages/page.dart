import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invola_task/bloc/page_data_bloc.dart';
import 'package:invola_task/repos/data_repo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isFavorite = false;
  Color _mainColor = Color(0xff9EA3B6);
  final _bloc = PageDataBloc();
  final _repo = PageRepository();
  @override
  void initState() {
    _bloc.add(GetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is HaveData) {
                  return _screen(context);
                } else if (state is Loading) {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Error) {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Text(state.error),
                  );
                }
                return Container();
              })),
    );
  }

  Column _screen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 250.0,
          child: Stack(
            children: <Widget>[
              _slider(context),
              _controlBar(context),
            ],
          ),
        ),
        _title(),
        _divider(),
        _trainer(),
        _divider(),
        _about(),
        _divider(),
        _cost(),
        SizedBox(
          height: 10.0,
        ),
        _submitButton(context),
      ],
    );
  }

  Widget _slider(BuildContext context) {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        dotBgColor: Colors.transparent,
        dotSize: 8.0,
        dotIncreaseSize: 1.3,
        dotSpacing: 14,
        dotHorizontalPadding: 5,
        indicatorBgPadding: 10,
        dotPosition: DotPosition.bottomLeft,
        images: _repo.imgs.map((e) {
          return NetworkImage(e);
        }).toList(),
      ),
    );
  }

  Widget _controlBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24, left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.arrow_back_ios,
            size: 19,
            color: Colors.white,
          ),
          ButtonBar(
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 19,
                    color: Colors.white,
                  ),
                  onPressed: null),
              InkWell(
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                child: Icon(
                  _isFavorite ? Icons.star : Icons.star_border,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '#${_repo.data['interest']}',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            '${_repo.data['title']}',
            style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold, color: _mainColor),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.date_range,
                color: _mainColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${_repo.data['date']}',
                style: TextStyle(color: _mainColor, fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                  width: 18.0,
                  height: 18.0,
                  child: Image.asset('assets/pin.png')),
              SizedBox(
                width: 10,
              ),
              Text(
                '${_repo.data['address']}',
                style: TextStyle(color: _mainColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _trainer() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 15.0,
                backgroundImage: NetworkImage('${_repo.avatar}'),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                '${_repo.data['trainerName']}',
                style: TextStyle(
                    color: _mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${_repo.data['trainerInfo']}',
            style: TextStyle(
              color: _mainColor,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _about() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'عن الدوره',
            style: TextStyle(
                color: _mainColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            ' ${_repo.data['occasionDetail']}',
            style: TextStyle(
              color: _mainColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Divider(),
    );
  }

  Widget _cost() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'تكلفه الدورة',
            style: TextStyle(
                fontSize: 16, color: _mainColor, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'الحجز العادي',
                style: TextStyle(color: _mainColor, fontSize: 16),
              ),
              Text(
                '${_repo.data['price']} SAR',
                style: TextStyle(color: _mainColor, fontSize: 16),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'الحجز المميز',
                style: TextStyle(color: _mainColor, fontSize: 16),
              ),
              Text(
                '${_repo.data['price']} SAR',
                style: TextStyle(color: _mainColor, fontSize: 16),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'الحجز السريع',
                style: TextStyle(color: _mainColor, fontSize: 16),
              ),
              Text(
                '${_repo.data['price']} SAR',
                style: TextStyle(color: _mainColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff79358C),
        alignment: Alignment.center,
        child: Text(
          'قم بالحجز الان',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
