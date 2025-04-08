table 52177859 "Training Evaluation Lines"
{

    fields
    {
        field(1; "Training Evaluation No."; Code[20])
        {
            //DataClassification = ToBeClassified;
            TableRelation = "Training Evaluation Header"."Training Evaluation No.";
        }
        field(2; "Personal No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Evaluation Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Course,Utilization,Expectation,Impact,TrainingTechniques,TrainingVenueFood,Recommendation,PersonlActionPlans,Barriers,OvercomingBarriers,ResourceReq,ImprovingWeakness,RecommendationNo';
            OptionMembers = " ",Course,Utilization,Expectation,Impact,TrainingTechniques,TrainingVenueFood,Recommendation,PersonlActionPlans,Barriers,OvercomingBarriers,ResourceReq,ImprovingWeakness,RecommendationNo;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Action Plan"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "How To achieve"; Text[250])
        {
            Caption = 'How to achieve the action Plan';
            DataClassification = ToBeClassified;
        }
        field(8; "Results to be achieved"; Text[250])
        {
            Caption = 'Results to be achieved (Targets)';
            DataClassification = ToBeClassified;
        }
        field(9; Timeline; Text[250])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; "Training Evaluation No.", "Evaluation Line Type", "Personal No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;


}

