#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 65008 "ACA-Bulk Units Reg. List"
{
    CardPageID = "ACA-Bulk Units Registration";
    PageType = List;
    SourceTable = "ACA-Bulk Units Registration";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Semester Code";Rec."Semester Code")
                {
                    ApplicationArea = Basic;
                }
                field("Academic Year";Rec."Academic Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Program Code";Rec."Program Code")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Code";Rec."Unit Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        Rec.SetFilter("User ID",UserId);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("User ID",UserId);
    end;
}

