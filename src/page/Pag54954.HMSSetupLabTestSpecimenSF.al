page 54954 "HMS-Setup Lab Test Specimen SF"
{
    PageType = ListPart;
    SourceTable = "HMS-Setup Test Specimen";

    layout
    {
        area(content)
        {
            repeater(Rep)
            {

                field("Lab Test"; Rec."Lab Test")
                {
                    ApplicationArea = All;
                    // TableRelation = "Speciment  list";
                    // ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                    // trigger OnValidate()
                    // var
                    //     LabResults: Record "Speciment  list";
                    // begin
                    //     LabResults.Reset();
                    //     begin
                    //         rec."Lab Test Description" := LabResults."Lab Test Description";
                    //         // rec."Normal Range" := LabResults."Normal Range";
                    //         rec.unit := LabResults.unit;
                    //         rec.Modify();
                    //     end;

                    // end;
                }
                field("Lab Test Description"; Rec."Lab Test Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lab Test Description field.', Comment = '%';
                }

                field(unit; Rec.unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;

                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Non-Ranged Result"; rec."Non-Ranged Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                }
                field("Minimum Value"; rec."Minimum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                    Visible = not HideListFields;
                }
                field("Maximum Value"; rec."Maximum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Speciment Description field.', Comment = '%';
                    Visible = not HideListFields;
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Flag field.', Comment = '%';
                }

            }
        }

    }
    actions
    {

        area(Processing)
        {
            action("Print Lab Test Report")
            {
                Caption = 'Print Lab Test Report';
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    hms.Reset();
                    hms.SetRange("Patient No.", Rec."Patient No.");
                    hms.SetRange("Laboratory Test Package Code", Rec."Lab Test");
                    if hms.Find('-') then begin
                        Report.Run(Report::"Lab results preview", true, true, hms);
                    end;
                end;



            }
            action(" non rangedPrint Lab Test Report")
            {
                Caption = 'Print non-ranged Lab Test Report';
                ApplicationArea = All;
                Image = Print;
                RunObject = report "Non-Range Results";


            }
        }

    }
    procedure SetHideListFields(Hide: Boolean)
    begin
        HideListFields := Hide;
        CurrPage.Update();
    end;

    var
        HideListFields: Boolean;
        hms: Record "HMS-Treatment Form Laboratory";
}

