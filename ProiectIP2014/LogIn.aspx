﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LogIn.aspx.cs" Inherits="SignIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container" style="background-color: ghostwhite;">
       <asp:LoginView ID="LoginView1" runat="server">
            <AnonymousTemplate>
                <asp:Login ID="Login1" runat="server"></asp:Login>
            </AnonymousTemplate>
        </asp:LoginView>
    </div> <!-- /container -->
    
</asp:Content>
