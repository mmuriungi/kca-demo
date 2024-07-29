page 51110 "HRM-Appraisal Reg List 2"
{
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Appraisal Registration";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {

                    Editable = true;
                }
                field("PF No."; Rec."PF No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Editable = true;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {

                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Editable = true;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = true;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Editable = true;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Appraisal Jobs Category"; Rec."Appraisal Jobs Category")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        Cust: Record Customer;
}

