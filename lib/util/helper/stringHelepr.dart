class StringHelper{

  static String newsTime(DateTime newsTime){
    final now = DateTime.now();
    final diff = now.difference(newsTime);
    if(diff.inSeconds < 60){
      return '${diff.inSeconds} Seconds ago';
    }else if(diff.inMinutes < 60){
      return '${diff.inMinutes} Minutes ago';
    }else if(diff.inHours < 24){
      return '${diff.inHours} Hours ago';
    }else if(diff.inDays < 7){
      return '${diff.inDays} Days ago';
    }else if(diff.inDays > 7){
      return '${diff.inDays%7} Weeks ago';
    }else if(diff.inDays > 30){
      return '${diff.inDays%30} Months ago';
    }else {
      return 'A Long time ago';
    }
  }

  static String newsTimeSimple(DateTime newsTime){
    final now = DateTime.now();
    final diff = now.difference(newsTime);
    if(diff.inSeconds < 60){
      return '${diff.inSeconds} S';
    }else if(diff.inMinutes < 60){
      return '${diff.inMinutes} M';
    }else if(diff.inHours < 24){
      return '${diff.inHours} H';
    }else if(diff.inDays < 7){
      return '${diff.inDays} D';
    }else if(diff.inDays > 7){
      return '${diff.inDays%7} W';
    }else if(diff.inDays > 30){
      return '${diff.inDays%30} M';
    }else {
      return 'A Long time ago';
    }
  }
}