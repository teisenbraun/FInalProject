function [] = finalGradeInterface()
    
    %creates the figure that will show up when the code is ran and gave it
    %the name "Final Grade Calculator"
    fig = figure('numbertitle','off','name','Final Grade Calculator');
    
    %creates editable text boxes for the user to input data needed to
    %calculate their needed final exam grade or overall grade
    gradesText = uicontrol('style','text','units','normalized','position',[0.15 0.95 0.7 0.05],'string','Enter Grades Below (In Decimal Form, Separated By Commas)');
    grades = uicontrol('style','edit','units','normalized','position',[0.25 0.9 0.5 0.05]);
    
    weightsText = uicontrol('style','text','units','normalized','position',[0.15 0.8 0.7 0.05],'string','Enter Weights Below (In Decimal Form, Separated By Commas)');
    weights = uicontrol('style','edit','units','normalized','position',[0.25 0.75 0.5 0.05]);
    
    desiredGradeText = uicontrol('style','text','units','normalized','position',[0.25 0.65 0.5 0.05],'string','Enter Desired Grade Below');
    desiredGrade = uicontrol('style','edit','units','normalized','position',[0.25 0.6 0.5 0.05]);
    
    finalExamWeightText = uicontrol('style','text','units','normalized','position',[0.25 0.5 0.5 0.05],'string','Enter Weight of Final Exam Below');
    finalExamWeight = uicontrol('style','edit','units','normalized','position',[0.25 0.45 0.5 0.05]);
    
    finalExamGradeText = uicontrol('style','text','units','normalized','position',[0.25 0.35 0.5 0.05],'string','Enter Grade on Final Exam (Optional)');
    finalExamGrade = uicontrol('style','edit','units','normalized','position',[0.25 0.3 0.5 0.05]);
    
    %creates two pushbuttons that can be used to either output
    %the grade needed on the final exam or the overall grade in the class.
    calculateButton = uicontrol('style','pushbutton','units','normalized','position',[0.1 0.1 0.35 0.1],'string','Calculate Grade Needed on Final!', 'callback', {@finalGradeCalculator, grades, weights, desiredGrade, finalExamWeight});
    finalGradeButton = uicontrol('style','pushbutton','units','normalized','position',[0.6 0.1 0.35 0.1],'string','Calculate Overall Grade!', 'callback', {@overallGradeCalculator, grades, weights, finalExamGrade,finalExamWeight});
    
end

function [] = finalGradeCalculator(calculateButton, event, grades, weights, desiredGrade, finalExamWeight)

    %if-statements used to make sure that data is inputted and of the
    %correct type and format
    if isempty(get(grades,'string')) == 1 || isempty(regexp(get(grades,'string'), '([0-9][\.][0-9]+)+', 'once')) == 1
        
        fprintf("Please Enter Grade Values\n");
        
    elseif isempty(get(weights, 'string')) == 1 || isempty(regexp(get(weights,'string'), '([0-9][\.][0-9]+)+', 'once')) == 1
        
        fprintf("Please Enter Weight Values\n");
        
    elseif isempty(get(desiredGrade, 'string')) == 1 || isempty(regexp(get(desiredGrade,'string'), '([0-9][\.][0-9]+)', 'once')) == 1
        
        fprintf("Please Enter A Desired Grade Value\n");
        
    elseif isempty(get(finalExamWeight, 'string')) == 1 || isempty(regexp(get(finalExamWeight,'string'), '([0-9][\.][0-9]+)', 'once')) == 1
        
        fprintf("Please Enter The Weight of The Final Exam\n");
        
    else

    %converts input from a string to a double array so that mathematical
    %operations can be done on the data
    userInputGradesString = strsplit(get(grades, 'string'),',');
    userInputGrades = str2double(userInputGradesString);
    
    userInputWeightsString = strsplit(get(weights, 'string'),',');
    userInputWeights = str2double(userInputWeightsString);
    
    %if-statement that checks to make sure that each grade has a
    %corresponding weight
    if length(userInputGrades) ~= length(userInputWeights)
        
        fprintf("Grades And Weights Must Be of Equal Length\n");
        
    else
    
    userInputDesiredGrade = str2double(get(desiredGrade, 'string'));
    
    userInputFinalWeight = str2double(get(finalExamWeight, 'string'));

    categoryGrade = zeros(1,length(userInputGrades));
    
    sumOfGrades = 0;
    
    %a for-loop that will go through the inputted grades and corresponding
    %weights and save the results in a new array. Then sum them all up to
    %get a total grade
    for i = 1:length(userInputGrades)
        
        categoryGrade(i) = (userInputGrades(i)) * (userInputWeights(i));
        sumOfGrades = sumOfGrades + categoryGrade(i);
        
    end
    
    %calculation for finding the grade the user must get on their final
    %exam to get the desired graded inputted.
    finalGradeNeeded = ((userInputDesiredGrade - sumOfGrades)/(userInputFinalWeight)) * 100;
    
    desiredPercent = userInputDesiredGrade * 100;
    
    fprintf("You would need a %d on the final exam to get a %d in the class.\n",int16(finalGradeNeeded),int16(desiredPercent));
    
    end
    
    end
    
end
        
function [] = overallGradeCalculator(finalGradeButton, event, grades, weights, finalExamGrade, finalExamWeight)

    %if-statements used to make sure that data is inputted and of the
    %correct type and format
    if isempty(get(grades,'string')) == 1 || isempty(regexp(get(grades,'string'), '([0-9][\.][0-9]+)+', 'once')) == 1
        
        fprintf("Please Enter Grade Values\n");
        
    elseif isempty(get(weights, 'string')) == 1 || isempty(regexp(get(weights,'string'), '([0-9][\.][0-9]+)+', 'once')) == 1
        
        fprintf("Please Enter Weight Values\n");
        
    elseif isempty(get(finalExamWeight, 'string')) == 1 || isempty(regexp(get(finalExamWeight,'string'), '([0-9][\.][0-9]+)', 'once')) == 1
        
        fprintf("Please Enter The Weight of The Final Exam\n");
        
    elseif isempty(get(finalExamGrade, 'string')) == 1 || isempty(regexp(get(finalExamGrade,'string'), '([0-9][\.][0-9]+)', 'once')) == 1
        
        fprintf("Please Enter Your Grade On The Final Exam\n");
        
    else
        
    %converts input from a string to a double array so that mathematical
    %operations can be done on the data
    userInputGradesString = strsplit(get(grades, 'string'),',');
    userInputGrades = str2double(userInputGradesString);
    
    userInputWeightsString = strsplit(get(weights, 'string'),',');
    userInputWeights = str2double(userInputWeightsString);
    
    %if-statement that checks to make sure that each grade has a
    %corresponding weight
    if length(userInputGrades) ~= length(userInputWeights)
        
        fprintf("Grades And Weights Must Be of Equal Length\n");
        
    else
        
    userInputFinalExamGrade = str2double(get(finalExamGrade, 'string'));
    
    userInputFinalWeight = str2double(get(finalExamWeight, 'string'));

    categoryGrade = zeros(1,length(userInputGrades));
    
    sumOfGrades = 0;
    
    %a for-loop that will go through the inputted grades and corresponding
    %weights and save the results in a new array. Then sum them all up to
    %get a total grade
    for i = 1:length(userInputGrades)
        
        categoryGrade(i) = (userInputGrades(i) * userInputWeights(i));
        sumOfGrades = sumOfGrades + categoryGrade(i);
        
    end
    
    %calculation needed to get the users overall grade in the class in
    %percentage form.
    overallGrade = (sumOfGrades + (userInputFinalExamGrade * userInputFinalWeight)) * 100;
    
    fprintf("You got a %d in the class.\n", int16(overallGrade));
    
    end
    
    end
    
end
        