page 50096 "Library Patrons"
{
    Caption = 'Library Patrons';
    PageType = ListPart;
    SourceTable = Customer;
    SourceTableView = SORTING("No.") ORDER(Descending) WHERE("Customer Type" = CONST(Student));
    CardPageId = "Customer Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Library Username"; Rec."Library Username")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send to Koha")
            {
                Caption = 'Send to Koha';
                Image = SynchronizeWithExchange;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    KohaHandler: Codeunit "Koha Handler";
                begin
                    KohaHandler.CreateStudentPatron(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Customer Type", Rec."Customer Type"::Student);
    end;
}
