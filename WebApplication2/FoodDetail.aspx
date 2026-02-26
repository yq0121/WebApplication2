<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FoodDetail.aspx.cs" Inherits="WebApplication2.FoodDetail" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Food Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <form id="form1" runat="server">
            <div class="container mt-5">
                <div class="card p-4 shadow">

                    <!--Food Name & Price -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <img id="imgFood" runat="server" class="img-fluid rounded" />
                        </div>
                        <div class="col-md-8">
                            <h3>
                                <asp:Label ID="lblFoodName" runat="server"></asp:Label>
                            </h3>
                            <h5 class="text-muted">
                                $ <asp:Label ID="lblPrice" runat="server"></asp:Label>
                            </h5>
                            <p class="mt-2 text-secondary">
                                <asp:Literal ID="litDescription" runat="server"></asp:Literal>

                                <!-- Read more -->
                                <a href="#" id="lnkReadMore" class="ms-1 text-primary" onclick="showDescriptionModal(); return false;">Read more</a>

                            </p>
                        </div>
                    </div>

                    <hr />

                   <!-- Flavor -->
                    <asp:Panel ID="pnlFlavor" runat="server" Visible="false">
                        <h5>Choose Flavor</h5>
                        <asp:DropDownList ID="ddlFlavor" runat="server" CssClass="form-select mb-3"></asp:DropDownList>
                    </asp:Panel>

                    <!-- Extras -->
                    <asp:Panel ID="pnlExtras" runat="server" Visible="false">
                        <h5>Extras</h5>
                        <asp:CheckBoxList ID="cblExtras" runat="server" CssClass="mb-3"></asp:CheckBoxList>
                    </asp:Panel>

                    <!-- ===== Special Request (All Food) ===== -->
                    <div class="mb-3">
                        <label class="form-label">Special Request</label>
                        <asp:TextBox ID="txtSpecialRequest" runat="server"
                            CssClass="form-control"
                            Placeholder="E.g. no onion, less sauce..." />
                    </div>

                    <!-- Add Cart -->
                    <div class="d-flex gap-2">
                        <asp:Button ID="btAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-success w-100 mt-2" OnClick="btnAddToCart_Click" />
                    
                        <!-- Back To Menu -->
                        <a href="Default.aspx" class="btn btn-secondary w-100 mt-2"> ← Back To Menu</a>
                    </div>

                    <!-- ===== Description Modal ===== -->
                    <div class="modal fade" id="descModal" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header">
                                    <h5 class="modal-title">
                                        <asp:Label ID="lblModalFoodName" runat="server"></asp:Label>
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                    <asp:Literal ID="litFullDescription" runat="server"></asp:Literal>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    <script>
        function showDescriptionModal() {
            console.log("Read more clicked");
            var modal = new bootstrap.Modal(document.getElementById('descModal'));
            modal.show();
        }
    </script>
</body>
</html>