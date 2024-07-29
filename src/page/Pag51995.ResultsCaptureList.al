page 51995 "Results Capture List"
{
    ApplicationArea = All;
    Caption = 'Results Capture List';
    PageType = List;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Results Capture Card";
    SourceTable = "Results Capture Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ToolTip = 'Specifies the value of the Semester Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lecturer PF No."; Rec."Lecturer PF No.")
                {
                    ToolTip = 'Specifies the value of the Lecturer PF No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lecturer User ID"; Rec."Lecturer User ID")
                {
                    ToolTip = 'Specifies the value of the Lecturer User ID field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lecturer Name"; Rec."Lecturer Name")
                {
                    ToolTip = 'Specifies the value of the Lecturer Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Program Name"; Rec."Program Name")
                {
                    ToolTip = 'Specifies the value of the Program Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ToolTip = 'Specifies the value of the Unit Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // action(GetPwd)
            // {
            //     Caption = 'pwd';
            //     //   Visible = boolVisibility;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         hrEmps: Record "HRM-Employee C";
            //         custs: Record Customer;
            //     begin
            //         // IF hrEmps.Get(Rec."Lecturer PF No.") then
            //         // Message(hrEmps."Portal Password");
            //         Clear(custs);
            //         custs.Reset();
            //         custs.SetRange("Customer Posting Group", 'STUDENT');
            //         if custs.Find('-') then begin
            //             repeat
            //             begin
            //                 custs."Global Dimension 1 Code" := 'MAIN';
            //                 custs.Modify();
            //             end;
            //             until custs.Next() = 0;
            //         end;
            //     end;
            // }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        RecDets: Record "Results Capture Header";
    begin
        Rec.SetFilter("Lecturer User ID", UserId);
        RecDets.Reset();
        RecDets.SetRange("Lecturer User ID", UserId);
        if RecDets.Find('-') then begin
            repeat
            begin
                RecDets.Password := '';
                if RecDets.Modify(true) then;
            end;
            until RecDets.Next() = 0;
        end;
        //   if UserId = 'TOM' then boolVisibility := true else boolVisibility := false;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec.SetFilter("Lecturer User ID", UserId);
    end;

    var
        boolVisibility: Boolean;

}
