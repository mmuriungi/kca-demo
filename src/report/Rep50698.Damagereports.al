report 50698 "Damage reports"
{
    Caption = 'Damage reports';
    RDLCLayout = './Layouts/damages.rdl';
    dataset
    {
        dataitem(damages; damages)
        {
            RequestFilterFields = status, "student  Number", "damage cost ";
            column(damagenumber; "damage number")
            {
            }
            column(DamageDescription; "Damage Description")
            {
            }
            column(studentNumber; "student  Number")
            {
            }
            column(studentName; "student Name ")
            {
            }
            column(studentEmail; "student Email")
            {
            }
            column(studentphonenumber; "student phone number")
            {
            }
            column(itemname; "item name ")
            {
            }
            column(damagecost; "damage cost ")
            {
            }
            column(dvccomment; "dvc comment ")
            {
            }
            column(financecomment; "finance comment ")
            {
            }
            column(status; status)
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
            trigger OnAfterGetRecord()
            begin
                info.get;
                info.CalcFields(Picture);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
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
