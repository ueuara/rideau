<%@page import="model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.CreditCard"%>
<%
	CreditCard c = (CreditCard) request.getAttribute("creditCard");
	ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ご注文内容確認</title>
</head>
<body>
  <h1>ご注文内容確認</h1>
  <br>
  <br>
  <br>
  <br>
  <h1>商品詳細</h1>
  <br>
  <%
  	for (Cart cart : cartList) {
  %>
  <table>
    <tbody>
      <tr>
        <th>柄</th>
        <td><%=cart.getPattern_cd()%></td>
      </tr>
      <tr>
        <th>サイズ縦</th>
        <td><%=cart.getSize_price_cd()%></td>
      </tr>
      <tr>
        <th>サイズ横</th>
        <td><%=cart.getSize_price_cd()%></td>
      </tr>
      <tr>
        <th>フックの有無</th>
        <td><%=cart.isHook_flg()%></td>
      </tr>
      <tr>
        <th>裏地の有無</th>
        <td><%=cart.isLiner_flag()%></td>
      </tr>
      <tr>
        <th>数量</th>
        <td><%=cart.getQuantity()%></td>
      </tr>
      <tr>
        <th>価格</th>
        <td><%=cart.getPrice()%></td>
      </tr>
    </tbody>
  </table>
  <%
  	}
  %>
  <p>合計金額：～</p>

  <h1>お届け情報</h1>
  <br>
  <p>お届け先</p>
  <br> ~~~~~~~~ ~~~~~~~~
  <p>配送方法</p>
  <br> ~~~~~~~ ~~~~~~~

  <h1>ご請求情報</h1>
  <br> ご請求先：お届け先と同じ
  <br> お支払い方法：クレジットカード決済(<%=c.getCreditCard()%>)


  <form action="/rideau/OrderConfirmation" method="post">
    <input type hidden> <input type="submit" value="注文確定">
  </form>

  <a href="/WEB-INF/jsp/Creditcard.jsp">クレジットカード情報入力に戻る"></a>
  <br>

  <a href="/WEB-INF/jsp/Cart.jsp">カートへ戻る</a>
  <br>
</body>
</html>