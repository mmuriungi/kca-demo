/// <summary>
/// Page Vendor Categories (ID 52178586).
/// </summary>
page 52178602 "Vendor Categories"
{
    Caption = 'Vendor Categories';
    PageType = List;
    SourceTable = "Vendor Categories";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Preq Year"; Rec."Preq Year")
                {
                   ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                   
                }
            }
        }
    }
}
