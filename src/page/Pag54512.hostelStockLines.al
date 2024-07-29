page 54512 "hostel Stock Lines"
{
    Caption = 'hostel Stock Lines';
    PageType = ListPart;
    SourceTable = "hostel stock lines";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("transaction type"; rec."transaction type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';

                }
                field("Reason for adjustment"; rec."Reason for adjustment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';

                }
                field(Staff; rec.Staff)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    trigger OnValidate()
                    var
                        hr: Record "HRM-Employee C";
                    begin
                        if hr.Get(rec."No.") then begin
                            rec.Name := hr."First Name" + ' ' + hr."Last Name" + ' ' + hr."Middle Name";
                            rec.Modify();
                        end;
                    end;

                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }

            }
        }
    }
}