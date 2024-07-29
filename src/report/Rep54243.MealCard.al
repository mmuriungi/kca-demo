report 54243 "Meal Card"
{
    Caption = 'Meal Card';
    DefaultLayout = RDLC;
    RDLCLayout = './POS/Report/SSR/mealcard.rdl';
    dataset
    {
        dataitem(CafeMembers; "Cafe Members")
        {
            RequestFilterFields = "No.";
            column(CardSerial; "Card Serial")
            {
            }
            column(No; "No.")
            {
            }
            column(MemberType; "Member Type")
            {
            }
            column(Names; Names)
            {
            }
            column(Pic; Pic)
            {
            }
            column(logo; info.Picture)
            {

            }
            column(CompName; info.Name)
            {

            }
            trigger OnPreDataItem()
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
    var
        info: Record "Company Information";
}
