import 'package:flutter/material.dart';
import 'package:responsi/model/modelDetailAgent.dart';
import 'package:responsi/services/apiDataSource.dart';

class DetailAgent extends StatelessWidget {
  final String uuid;
  const DetailAgent({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uuid),
      ),
      body: _buildDetailAgent(uuid),
    );
  }

  Widget _buildDetailAgent(String uuid) {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailAgent(uuid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildError();
          }
          if (snapshot.hasData) {
            DetailAgent detailAgent = DetailAgent.fromJson(snapshot.data);
            return _buildSuccess(detailAgent);
          }
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildError() {
    return Text("Error");
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccess(Data data) {
    return ListView(
      children: [
        if (data.displayIcon != null && data.displayIcon!.isNotEmpty)
          Image.network(data.displayIcon!),
        SizedBox(height: 16.0),
        Text(
          data.displayName ?? 'No Name',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.0),
        Text(
          data.description!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
