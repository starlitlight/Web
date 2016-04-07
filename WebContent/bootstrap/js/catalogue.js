function delete_confirm() {
    var msg = "您确定要删除该目录吗？";
    if (confirm(msg)==true){
      return true;
    }else{
      return false;
    }
}