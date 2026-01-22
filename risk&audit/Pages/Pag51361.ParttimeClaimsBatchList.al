page 52097 "Parttime Claims Batch List"
{
    ApplicationArea = All;
    Caption = 'Parttime Claims Batch List';
    CardPageId = "Parttime Claims Batch Card";
    Editable = false;
    PageType = List;
    SourceTable = "Parttime Claims Batch";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the batch.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the batch.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the batch.';
                }
                field("Claims Count"; Rec."Claims Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of claims in the batch.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester for the claims batch.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the batch.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the batch was created.';
                }
                field("Pv Generated"; Rec."Pv Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a PV has been generated for this batch.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {

        }
        area(Processing)
        {
            action(GeneratePV)
            {
                ApplicationArea = All;
                Caption = 'Generate PV';
                Image = Payment;
                ToolTip = 'Generate payment voucher for this batch.';

                trigger OnAction()
                begin
                    // Code to generate PV will be implemented here
                    if Confirm('Do you want to generate a payment voucher for this batch?') then begin
                        // Add PV generation logic
                        Message('PV generation functionality will be implemented.');
                    end;
                end;
            }
        }
    }
}
