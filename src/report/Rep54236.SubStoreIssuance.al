report 54236 "Sub Store Issuance"
{
    Caption = 'Sub Store Issuance';
    RDLCLayout = './hostel/storeTransactions.rdl';
    dataset
    {
        dataitem(hostelstocklines; "hostel stock lines")
        {
            RequestFilterFields = "transaction type";
            column(No; "No.")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(transactiontype; "transaction type")
            {
            }
            column(Reasonforadjustment; "Reason for adjustment")
            {
            }
            column(Staff; Staff)
            {
            }
            column(logo; info.Picture)
            {

            }
            column(cname; info.Name)
            {

            }
            column(caddress; info.Address)
            {

            }
            column(cmail; info."E-Mail")
            {

            }
            column(curl; info."Home Page")
            {

            }
            column(cphone; info."Phone No.")
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        info.get;
        info.CalcFields(Picture);
    end;

    var
        info: Record "Company Information";
}
