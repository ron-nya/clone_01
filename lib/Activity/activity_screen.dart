import 'package:authentication/constants/gaps.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _activitys = ['All', 'Replies', 'Mentions', 'Verified'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _activitys.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // 탭 선택 상태가 변경될 때 화면을 다시 그리기 위해 사용
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // HomeTab의 AppBar 높이 설정
        child: AppBar(
          elevation: 0,
          toolbarHeight: 120,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v16,
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            labelPadding: const EdgeInsets.only(right: 10),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            isScrollable: true,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              for (var i = 0; i < _activitys.length; i++)
                _buildTab(_activitys[i], i),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/11/320/240'),
            ),
            title: Row(
              children: [
                Text('john_mobbin'),
                SizedBox(width: 8),
                Text('4h', style: TextStyle(color: Colors.grey)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mentioned you',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Here's a thread you should follow if you love botany @jane_mobbin",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            isThreeLine: true,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/12/320/240'),
            ),
            title: Row(
              children: [
                Text('john_mobbin'),
                SizedBox(width: 8),
                Text('4h', style: TextStyle(color: Colors.grey)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Starting out my gardening club with three weekdays for our club!!',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  maxLines: 1,
                  'Count me in!',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            isThreeLine: true,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/13/320/240'),
            ),
            title: const Row(
              children: [
                Text('the.plantdads'),
                SizedBox(width: 8),
                Text('5h', style: TextStyle(color: Colors.grey)),
              ],
            ),
            subtitle: const Text('Followed you',
                style: TextStyle(color: Colors.grey)),
            trailing: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Following',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/14/320/240'),
            ),
            title: Row(
              children: [
                Text('the.plantdads'),
                SizedBox(width: 8),
                Text('5h', style: TextStyle(color: Colors.grey)),
              ],
            ),
            subtitle: Text(
              'Definitely broken! 🧵 👀 🌱',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/15/320/240'),
            ),
            title: Row(
              children: [
                Text('theberryjungle'),
                SizedBox(width: 8),
                Text('5h', style: TextStyle(color: Colors.grey)),
              ],
            ),
            subtitle: Text('🌱 👀 🧵', style: TextStyle(color: Colors.black)),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    bool isSelected = _tabController.index == index;
    return Tab(
      child: Container(
        width: 120,
        height: 35,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
