﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Mesaje_caut.aspx.cs" Inherits="Mesaje_caut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container" style="max-width: 1000px;">
        <div id="asd" runat="server">

        </div>
        <asp:LoginView ID="LoginView2" runat="server">
            <AnonymousTemplate>
                  <div class="jumbotron">
                    <p>Trebuie sa fii logat pentru a putea trimite mesaje!</p>
                  </div>
            </AnonymousTemplate>

            <RoleGroups>
                <asp:RoleGroup Roles="ONG">
                    <ContentTemplate>
                        <%--SideBar - Stanga--%>
                        <div class="col-xs-3 container" id="sidebar_left" role="navigation">
                          <div class="list-group">
                              <%--conv cu mesaje necitite--%>
                              <a href="#" class="list-group-item active"">Mesaje necitite:</a>
                              <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSourceNeCitite">
                                  <ItemTemplate>
                                      <asp:HyperLink ID="HyperLink1" CssClass="list-group-item" ForeColor="#a94442" runat="server"
                                          NavigateUrl='<%# String.Format("Mesaje_new.aspx?to={0}", (DataBinder.Eval(Container.DataItem,"UserN").ToString())) %>' > 
                                           <%# DataBinder.Eval(Container.DataItem, "UserN").ToString() + " (" + DataBinder.Eval(Container.DataItem, "nrC").ToString() + ")" %>  
                                      </asp:HyperLink>
                                  </ItemTemplate>
                                  <EmptyDataTemplate>
                                      <a href="#" class="list-group-item">Niciun mesaj necitit!</a>
                                  </EmptyDataTemplate>
                              </asp:ListView>

                              <%--conversatii vechi--%>
                              <a href="#" class="list-group-item active">Conversatii vechi:</a>
                              <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceCitite">
                                  <ItemTemplate>
                                      <asp:HyperLink ID="HyperLink1" CssClass="list-group-item" runat="server"
                                          NavigateUrl='<%# String.Format("Mesaje_new.aspx?to={0}", (DataBinder.Eval(Container.DataItem,"UserN").ToString())) %>' > 
                                           <%# DataBinder.Eval(Container.DataItem, "UserN").ToString() + " (" + DataBinder.Eval(Container.DataItem, "nrC").ToString() + ")" %>  
                                      </asp:HyperLink>
                                  </ItemTemplate>
                                  <EmptyDataTemplate>
                                      <a href="#" class="list-group-item">Nicio conversatie veche!</a>
                                  </EmptyDataTemplate>
                              </asp:ListView>
                              <asp:SqlDataSource runat="server" ID="SqlDataSourceNeCitite" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver GROUP BY aspnet_Users.UserName"> </asp:SqlDataSource>
                              <asp:SqlDataSource runat="server" ID="SqlDataSourceCitite" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand="SELECT aspnet_Users.UserName as UserN, COUNT(*) AS nrC FROM aspnet_Users INNER JOIN Conversatii ON aspnet_Users.UserId = Conversatii.cod_receiver GROUP BY aspnet_Users.UserName"> </asp:SqlDataSource>
                              
                            
                          </div>
                        </div><!--/span-->

                        <%--Main - centru--%>
                        <div class="col-xs-6 container" style="background-color: ghostwhite; padding-bottom:10px;">
                           
                            <%--ZONA CENTRALA--%>

                            <h3> Cautare in conversatii </h3>

                                <div id="Div2" runat="server" class="container col-xs-12">
                                    <asp:Label ID="Label1" runat="server" Text="De la: (campul poate fi lasat liber)"></asp:Label> <br/>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox> <br />
                                    <span class="text-danger"> <asp:Literal ID="UserExista" runat="server" Text=""></asp:Literal> </span>
                                    <br/>
                                    <asp:Label ID="Label2" runat="server" Text="Text cautat: (campul poate fi lasat liber)"></asp:Label> <br/>
                                    <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox> <br />
                                    <br/>
                                    <asp:Button ID="Button1" runat="server" Text="Cauta" OnClick="Button1_Click" CausesValidation="true"/> <br />
                                    <asp:Literal ID="Raspuns" runat="server" Text=""></asp:Literal>

                                    <br />

                                    <hr style='border-color: #428BCA; width:auto;' />

                                    <%--zona mesaje gasite--%>
                                    <div class="container col-xs-12">
                                        <asp:ListView ID="ListView3" runat="server" DataSourceID="SqlDataSourceMesaje">

                                            <EmptyDataTemplate>
                                                <table id="Table1" runat="server" style="">
                                                    <tr>
                                                        <td>Niciun mesaj.</td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>

                                            <%--bg-primary=albastru  bg-success=verde bg-info=albastruDeschis bg-danger:rosu
                                                eu:albastru, el:verde, el-necit:rosu--%>
                                            <ItemTemplate>
                                                <div class="bg-warning">
                                                    <div class="bg-primary" <%# mesaj_necitit(Eval("citit").ToString())  %>>
                                                        <span class="text-left"> &nbsp;de la: 
                                                            <a href="Mesaje_new.aspx?to=<%# Eval("senderN") %>" style="color: white; font-weight: 700;">
                                                                <%# Eval("senderN") %> 
                                                            </a>
                                                            pt: 
                                                            <a href="Mesaje_new.aspx?to=<%# Eval("receiverN") %>" style="color: white; font-weight: 700;">
                                                                <%# Eval("receiverN") %> 
                                                            </a>
                                                        </span>
                                                        <span class="text-right"> @ <%# Eval("data") %></span>
                                                    </div>

                                                    <div class="<%# culoare_text_comm( Eval("senderN").ToString() ) %> col-xs-12" <%# mesaj_necitit(Eval("citit").ToString())  %>>
                                                        <%# Eval("mesaj") %>
                                                    </div>

                                                </div>
                                            </ItemTemplate>

                                            <ItemSeparatorTemplate>
                                                <div class="row clearfix"></div>
                                                <br />
                                            </ItemSeparatorTemplate>

                                            <LayoutTemplate>
                                                <div id="itemPlaceHolder" runat="server">

                                                </div>
                                                <br />
                                                <asp:DataPager runat="server" ID="DataPager1">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                        <asp:NumericPagerField></asp:NumericPagerField>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                    </Fields>
                                                </asp:DataPager>
                                            </LayoutTemplate>

                                        </asp:ListView>

                                        <asp:SqlDataSource runat="server" ID="SqlDataSourceMesaje" ConnectionString='<%$ ConnectionStrings:MySqlConnection %>' SelectCommand=""></asp:SqlDataSource>
                                    </div>
                                </div>

                        </div>

                        <%--SideBar - Dreapta--%>
                        <div class="col-xs-3 container" id="sidebar" role="navigation">
                          <div class="list-group">
                            <a href="#" class="list-group-item active">Proiectele aflate in desfasurare</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item">Link</a>
                            <a href="#" class="list-group-item active">Mesaje</a>
                            <a href="Mesaje_main.aspx" class="list-group-item">Conversatiile mele</a>
                            <a href="Mesaje_new.aspx" class="list-group-item">Conversatie noua</a>
                            <a href="Mesaje_caut.aspx" class="list-group-item">Cauta in conversatii</a>
                            <a href="#" class="list-group-item">Link</a>
                          </div>
                        </div><!--/span-->

                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>

      <hr />

      <footer>
        <p>&copy; Company 2014</p>
      </footer>

    </div><!--/.container-->
</asp:Content>

