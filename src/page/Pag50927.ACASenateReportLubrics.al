page 50927 "ACA-Senate Report Lubrics"
{
    CardPageID = "ACA-Results Status Labels";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Academic Year";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    Enabled = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Current; Rec.Current)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Allow View of Transcripts"; Rec."Allow View of Transcripts")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(creation)
    //     {
    //         action("Update Grading System")
    //         {
    //             Caption = 'Update Grades';
    //             Image = ExportShipment;
    //             Promoted = true;
    //             PromotedIsBig = true;
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 ExamsProcessing: Codeunit "Exams Processing";
    //             begin

    //                 ExamsProcessing.UpdateGradingSystem(Rec.Code);
    //                 MESSAGE('Grading System Updated');
    //             end;
    //         }
    //     }
    // }
    actions
    {
        area(creation)
        {
            action("Update Grading System")
            {
                Caption = 'Update Grades';
                Image = ExportShipment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExamsProcessing: Codeunit "Exams Processing";
                begin

                    ExamsProcessing.UpdateGradingSystem(Rec.Code);
                    MESSAGE('Grading System Updated');
                end;
            }
            action(GenRubrics)
            {
                ApplicationArea = Basic;
                Caption = 'General Rubrics';
                Image = SuggestBin;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACAResultsStatus);
                    ACAResultsStatus.Reset;
                    ACAResultsStatus.SetRange("Academic Year", Rec.Code);
                    if ACAResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-Results Status List", ACAResultsStatus);
                end;
            }
            action(SuppSpecialRubrics)
            {
                ApplicationArea = Basic;
                Caption = 'Supp/Special Rubrics';
                Image = ExportElectronicDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACASuppResultsStatus);
                    ACASuppResultsStatus.Reset;
                    ACASuppResultsStatus.SetRange("Academic Year", Rec.Code);
                    if ACASuppResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-Supp. Gen. Rubrics", ACASuppResultsStatus);
                end;
            }
            action("2ndSuppRubrics")
            {
                ApplicationArea = Basic;
                Caption = '2nd Supp Rubrics';
                Image = DepreciationBooks;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACA2ndSuppResultsStatus);
                    ACA2ndSuppResultsStatus.Reset;
                    ACA2ndSuppResultsStatus.SetRange("Academic Year", Rec.Code);
                    if ACA2ndSuppResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-2ndSupp. Gen. Rubrics", ACA2ndSuppResultsStatus);
                end;
            }
            action(MediNursingRubrics)
            {
                ApplicationArea = Basic;
                Caption = 'Medical/Nursing Rubrics';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACAResultsStatus);
                    ACAResultsStatus.Reset;
                    ACAResultsStatus.SetRange("Academic Year", Rec.Code);
                    if ACAResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-Rubrics (Medicine)", ACAResultsStatus);
                end;
            }
            action(MediNursingSuppSpecialRubrics)
            {
                ApplicationArea = Basic;
                Caption = 'Nursing Supp/Special Rubrics';
                Image = GetStandardJournal;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACASuppResultsStatus);
                    ACASuppResultsStatus.Reset;
                    ACASuppResultsStatus.SetRange("Academic Year", Rec.Code);
                    ACASuppResultsStatus.SetRange("Special Programme Class", ACASuppResultsStatus."special programme class"::"Medicine & Nursing");
                    if ACASuppResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-Supp. Gen. Rubrics Nursing", ACASuppResultsStatus);
                end;
            }
            action(MediNursing2ndSuppRubrics)
            {
                ApplicationArea = Basic;
                Caption = 'Nursing 2nd Supp Rubrics';
                Image = DistributionGroup;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(ACA2ndSuppResultsStatus);
                    ACA2ndSuppResultsStatus.Reset;
                    ACA2ndSuppResultsStatus.SetRange("Academic Year", Rec.Code);
                    ACA2ndSuppResultsStatus.SetRange("Special Programme Class", ACA2ndSuppResultsStatus."special programme class"::"Medicine & Nursing");
                    if ACA2ndSuppResultsStatus.Find('-') then;
                    Page.Run(Page::"ACA-2ndSupp. Gen. Rubrics Nuri", ACA2ndSuppResultsStatus);
                end;
            }
        }
    }

    var
        ACAAcademicYear: Record "ACA-Academic Year";
        ACASuppResultsStatus: Record "ACA-Supp. Results Status";
        ACAResultsStatus: Record "ACA-Results Status";
        ACA2ndSuppResultsStatus: Record "ACA-2ndSupp. Results Status";
}
