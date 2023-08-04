classdef LightStim_APP < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        FullfieldCheckerboardTab        matlab.ui.container.Tab
        RGBEditField_Background         matlab.ui.control.EditField
        RGBValue0255EditFieldLabel      matlab.ui.control.Label
        RGBEditField_rectColor          matlab.ui.control.EditField
        RGBValue0255Label               matlab.ui.control.Label
        RunRandomCheckerboardIlluminationButton  matlab.ui.control.Button
        NumberofSetsSpinner             matlab.ui.control.Spinner
        NumberofSetsSpinnerLabel        matlab.ui.control.Label
        FrequencyHzEditField            matlab.ui.control.NumericEditField
        FrequencyHzEditFieldLabel       matlab.ui.control.Label
        RuntimeEditField                matlab.ui.control.NumericEditField
        RuntimeEditFieldLabel           matlab.ui.control.Label
        CheckerboardSizenxnSpinner      matlab.ui.control.Spinner
        CheckerboardSizenxnSpinnerLabel  matlab.ui.control.Label
        RunFullfieldIlluminationButton  matlab.ui.control.Button
        BackgroundColorDropDown         matlab.ui.control.DropDown
        BackgroundColorDropDownLabel    matlab.ui.control.Label
        FullfieldColorDropDown          matlab.ui.control.DropDown
        FullfieldColorDropDownLabel     matlab.ui.control.Label
        FullfieldIlluminationOFFEditField  matlab.ui.control.EditField
        FullfieldIlluminationOFFEditFieldLabel  matlab.ui.control.Label
        FullfieldIlluminationONEditField  matlab.ui.control.EditField
        FullfieldIlluminationONEditFieldLabel  matlab.ui.control.Label
        FullfieldIlluminationRepetitionSpinner  matlab.ui.control.Spinner
        FullfieldIlluminationRepetitionSpinnerLabel  matlab.ui.control.Label
        RecordCheckerboardHistorySwitch  matlab.ui.control.Switch
        RecordInputHistoryLabel_2       matlab.ui.control.Label
        RecordFullfieldHistorySwitch    matlab.ui.control.Switch
        RecordInputHistoryLabel         matlab.ui.control.Label
        RandomCheckerboardIlluminationLabel  matlab.ui.control.Label
        FullfieldIlluminationLabel      matlab.ui.control.Label
        ClearCheckerboardHistoryButton  matlab.ui.control.Button
        LoadCheckerboardProtocolButton  matlab.ui.control.Button
        SaveCheckerboardProtocolButton  matlab.ui.control.Button
        LoadFullfieldProtocolButton     matlab.ui.control.Button
        ClearFullfieldHistoryButton     matlab.ui.control.Button
        SaveFullfieldProtocolButton     matlab.ui.control.Button
        RuntimeDropDown                 matlab.ui.control.DropDown
        FullfieldIlluminationOFFDropDown  matlab.ui.control.DropDown
        FullfieldIlluminationONDropDown  matlab.ui.control.DropDown
        DoubleClicktoSTOPButton         matlab.ui.control.Button
        FullfieldIlluminationHistory    matlab.ui.control.Table
        CheckerboardHistory             matlab.ui.control.Table
        OpenWindowButton                matlab.ui.control.Button
        MovingBarTab                    matlab.ui.container.Tab
        RecordBarHistorySwitch          matlab.ui.control.Switch
        RecordInputHistoryLabel_3       matlab.ui.control.Label
        LoadBarProtocolButton           matlab.ui.control.Button
        ClearBarHistoryButton           matlab.ui.control.Button
        SaveBarProtocolButton           matlab.ui.control.Button
        BarHistory                      matlab.ui.control.Table
        BarVelocitymmsecEditField       matlab.ui.control.NumericEditField
        BarVelocitymmsecEditFieldLabel  matlab.ui.control.Label
        BarRepetitionSpinner            matlab.ui.control.Spinner
        BarRepetitionSpinnerLabel       matlab.ui.control.Label
        Tree                            matlab.ui.container.Tree
        HorizontalNode                  matlab.ui.container.TreeNode
        LefttoRightNode                 matlab.ui.container.TreeNode
        RighttoLeftNode                 matlab.ui.container.TreeNode
        VerticalNode                    matlab.ui.container.TreeNode
        ToptoBottomNode                 matlab.ui.container.TreeNode
        BottomtoTopNode                 matlab.ui.container.TreeNode
        DiagonalNode                    matlab.ui.container.TreeNode
        TopLefttoBottomRightNode        matlab.ui.container.TreeNode
        BottomLefttoTopRightNode        matlab.ui.container.TreeNode
        TopRIghttoBottomLeftNode        matlab.ui.container.TreeNode
        BottomRighttoTopLeftNode        matlab.ui.container.TreeNode
        ButtonGroup                     matlab.ui.container.ButtonGroup
        MoveButton                      matlab.ui.control.RadioButton
        StaticButton                    matlab.ui.control.RadioButton
        BarLengthmmEditField            matlab.ui.control.NumericEditField
        BarLengthmmEditFieldLabel       matlab.ui.control.Label
        RGBEditField_MovingBar          matlab.ui.control.EditField
        RGBValues0255Label              matlab.ui.control.Label
        BarColorDropDown                matlab.ui.control.DropDown
        BarColorDropDownLabel           matlab.ui.control.Label
        BarWidthmmEditField             matlab.ui.control.NumericEditField
        BarWidthmmEditFieldLabel        matlab.ui.control.Label
        BarAngleEditField               matlab.ui.control.NumericEditField
        BarAngleLabel                   matlab.ui.control.Label
        RunMovingBarIlluminationButton  matlab.ui.control.Button
        MovingBarIlluminationLabel      matlab.ui.control.Label
        OpenWindowButton_2              matlab.ui.control.Button
        ContextMenu                     matlab.ui.container.ContextMenu
        ApplySettingsMenu               matlab.ui.container.Menu
        DeleteRowMenu                   matlab.ui.container.Menu
        AddRowMenu                      matlab.ui.container.Menu
        ContextMenu2                    matlab.ui.container.ContextMenu
        ApplySettingsMenu_2             matlab.ui.container.Menu
        DeleteRowMenu_2                 matlab.ui.container.Menu
        AddRowMenu_2                    matlab.ui.container.Menu
    end


    properties (Access = private)
        %% Properties for default settings
        window % psychtoolbox window
        windowRect % rectangle that makes the background
        screenNumber % number of screens in system
        white % define white
        black % define black
        xCenter % x-axis middle point of windowRect
        yCenter % y-axis middle point of windowRect
        centeredRect % middle point of windowRect
        screenXpixels % number of pixels across width of windowRect
        screenYpixels % number of pixels across length of windowRect
        rectColor = [1 1 1]
        WindowColor = [0 0 0]
        %% Properties for moving bar
        barWidth = 182
        barLength = 1000
        barColor = [1 1 1]
        barAngle = 135
        selectedDirection
        barVelocity = 1
        
        %% Properties for stopping illumination
        stopFlag
        %% Properties for selected row on table
        RowIndices_fullfield % selected row on table of full-field illumination
        RowIndices_checkerboard % selected row on table of random checkerboard illumination

        funcResult
    end

    methods (Access = private)

        function ColorFunc(app, EditField)
            rgbInput = EditField;
            rgbValues = str2double(split(strrep(rgbInput, ' ', ','), ','));
            noNaNValues = rgbValues(~isnan(rgbValues));
            ColorVector = cat(1,noNaNValues)';
            Color = ColorVector/255;
            app.funcResult = Color;
        end
        
        function BarFunc(app, xpos, ypos, x, y, n, movepix, baseRect, vbl, waitframes, ifi)
            while 1
                % Position of the square on this frame
                barDiagonal = sqrt(app.barLength^2 + app.barWidth^2);
                squareXpos = xpos + x * (n * movepix - barDiagonal);
                squareYpos = ypos + y * (n * movepix - barDiagonal);
                centeredRect = CenterRectOnPointd(baseRect, squareXpos, squareYpos);
                % Draw the rotated rect to the screen
                Screen('glPushMatrix', app.window)
                Screen('glTranslate', app.window, squareXpos, squareYpos)
                Screen('glRotate', app.window, app.barAngle, 0, 0); % 135도
                Screen('glTranslate', app.window, -squareXpos, -squareYpos)
                Screen('FillRect', app.window, app.barColor, centeredRect);
                Screen('glPopMatrix', app.window)
                % Flip to the screen
                vbl  = Screen('Flip', app.window, vbl + (waitframes - 0.5) * ifi);
                n = n + 1;
                if app.selectedDirection == app.LefttoRightNode
                    if squareXpos > app.screenXpixels + barDiagonal
                        break
                    end
                elseif app.selectedDirection == app.RighttoLeftNode
                    if squareXpos + barDiagonal < 0 
                        break
                    end
                elseif app.selectedDirection == app.ToptoBottomNode
                    if squareYpos > app.screenYpixels + barDiagonal
                        break
                    end
                elseif app.selectedDirection == app.BottomtoTopNode
                    if squareYpos + barDiagonal < 0
                        break
                    end
                elseif app.selectedDirection == app.TopLefttoBottomRightNode
                    if squareXpos > app.screenXpixels + barDiagonal && squareYpos > app.screenYpixels + barDiagonal
                        break
                    end
                elseif app.selectedDirection == app.BottomLefttoTopRightNode
                    if squareXpos > app.screenXpixels + barDiagonal && squareYpos + barDiagonal< 0
                        break
                    end
                elseif app.selectedDirection == app.TopRIghttoBottomLeftNode
                    if squareXpos + barDiagonal < 0 && squareYpos > app.screenYpixels + barDiagonal
                        break
                    end
                elseif app.selectedDirection == app.BottomRighttoTopLeftNode
                    if squareXpos + barDiagonal < 0 && squareYpos + barDiagonal < 0
                        break
                    end
                end
            end
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Tree.FontColor = [0.65 0.65 0.65];
            app.BarRepetitionSpinner.FontColor = [0.65 0.65 0.65];
            app.BarRepetitionSpinnerLabel.FontColor = [0.65 0.65 0.65];
            app.BarVelocitymmsecEditField.FontColor = [0.65 0.65 0.65];
            app.BarVelocitymmsecEditFieldLabel.FontColor = [0.65 0.65 0.65];
            %% Default settings when app is launched
            sca;close all;clearvars;clc % Clear the workspace and the screen
            PsychDefaultSetup(2); % Here we call some default settings for setting up Psychtoolbox
            %%
            app.stopFlag = false; % Illumination not paused
            %% Default input values (사실 없어도 디자인뷰에서 숫자를 직접 바꾸는 편이 빠름)
            % app.FullfieldIlluminationRepetitionSpinner.Value = 10; % full-field 자극반복횟수, 기본=10
            % app.FullfieldIlluminationONEditField.Value = 4; % full-field 자극 ON 시간, 기본 4 sec
            % app.FullfieldIlluminationOFFEditField.Value = 4; % full-field 자극 OFF 시간, 기본 4 sec
            % app.FullfieldColorDropDown.Value = "White"; % full-field 정사각형 색, 기본 White
            % app.BackgroundColorDropDown.Value = "Black"; % full-field 배경색, 기본 Black
            % app.RecordFullfieldHistorySwitch.Value = "On"; % full-field 자극 설정 기록, 기본 ON
            %
            % app.CheckerboardSizenxnSpinner.Value = 8; % checkerboard 자극 배열 설정, 기본 8x8 배열
            % app.RuntimeEditField.Value = 1; % checkerboard 자극 시간 설정, 기본 1 sec
            % app.RuntimeDropDown.Value = "(s)";
            % app.FrequencyHzEditField = "10"; % checkerboard 자극 frequency 설정, 기본 10 Hz
            % app.NumberofSetsSpinner.Value = 1; % checkerboard 세트 반복 횟수, 기본 1 set
            % app.RecordCheckerboardHistorySwitch.Value = "On"; % checkerboard 자극 설정 기록, 기본 ON
            %% Selected rows in table
            % app.RowIndices_fullfield = 99; % define selected row when no row has been selected yet

            %% Number format
            format shortG
        end

        % Button pushed function: OpenWindowButton
        function OpenWindowButtonPushed(app, event)
            %% Open an on screen window & Open the serial port
            app.black = [0 0 0];
            screens=Screen('Screens'); % Get the screen numbers
            app.screenNumber=max(screens); % Select the maximum of these numbers
            app.white=WhiteIndex(app.screenNumber); % Define white
            app.black=BlackIndex(app.screenNumber); % Define black
            % s=serial('COM1'); % Find serial port
            % set(s,'BaudRate',57600);

            [app.window,app.windowRect]=PsychImaging('OpenWindow',app.screenNumber,app.black); % Open an on screen window and color it black
            [app.screenXpixels,app.screenYpixels]=Screen('WindowSize',app.window); % Get the size of the on screen window in pixels
            % fopen(s); % Open the serial port

            %% Positions of Full-field illumination circle
            % Get the center coordinate of the window
            [app.xCenter, app.yCenter] = RectCenter(app.windowRect);
            % Make a base Rect of 200 by 200 pixels
            baseRect = [0 0 1200 1000];
            % Center the rectangle on the center of the screen
            app.centeredRect = CenterRectOnPointd(baseRect, app.xCenter, app.yCenter);
        end

        % Button pushed function: RunFullfieldIlluminationButton
        function RunFullfieldIlluminationButtonPushed(app, event)
            app.stopFlag = false; % unpause any pauses
            %% Run full-field illumination
            %% Light stimulus protocol
            rep = app.FullfieldIlluminationRepetitionSpinner.Value; % 자극반복횟수
            visTime = app.FullfieldIlluminationONEditField.Value; % 자극 ON 시간, unit: sec
            invisTime = app.FullfieldIlluminationOFFEditField.Value; % 자극 OFF 시간, unit: sec

            
            Screen('FillRect',app.window, app.WindowColor, app.windowRect);
            Screen('Flip',app.window);

            %% Recording input settings on table
            % Record input values when switch is ON
            if app.RecordFullfieldHistorySwitch.Value == "On"
                % Get the user input from some GUI components (e.g., edit boxes)
                repetition = app.FullfieldIlluminationRepetitionSpinner.Value; % 자극반복횟수
                if app.FullfieldIlluminationONDropDown.Value == "(s)" % 자극 ON 시간 단위 정보
                    timeON = sprintf('%s (s)',app.FullfieldIlluminationONEditField.Value);
                elseif app.FullfieldIlluminationONDropDown.Value == "(ms)"
                    timeON = sprintf('%s (ms)',app.FullfieldIlluminationONEditField.Value);
                elseif app.FullfieldIlluminationONDropDown.Value == "(μs)"
                    timeON = sprintf('%s (μs)',app.FullfieldIlluminationONEditField.Value);
                end
                % 자극 OFF 시간 단위 정보
                if app.FullfieldIlluminationOFFDropDown.Value == "(s)"
                    timeOFF = sprintf('%s (s)',app.FullfieldIlluminationOFFEditField.Value);
                elseif app.FullfieldIlluminationOFFDropDown.Value == "(ms)"
                    timeOFF = sprintf('%s (ms)',app.FullfieldIlluminationOFFEditField.Value);
                elseif app.FullfieldIlluminationOFFDropDown.Value == "(μs)"
                    timeOFF = sprintf('%s (μs)',app.FullfieldIlluminationOFFEditField.Value);
                end

                if app.FullfieldColorDropDown.Value == "Other"
                    rgbInput = app.RGBEditField_rectColor.Value;
                    rgbValues = str2double(split(strrep(rgbInput, ' ', ','), ','));
                    noNaNValues = rgbValues(~isnan(rgbValues));
                    ColorVector = cat(1,noNaNValues)';
                    color_rectangle = char(sprintf("%d, %d, %d",ColorVector(1),ColorVector(2),ColorVector(3)));
                else
                    color_rectangle = app.FullfieldColorDropDown.Value; % 가운데 사각형 색깔
                end

                if app.BackgroundColorDropDown.Value == "Other"
                    rgbInput = app.RGBEditField_Background.Value;
                    rgbValues = str2double(split(strrep(rgbInput, ' ', ','), ','));
                    noNaNValues = rgbValues(~isnan(rgbValues));
                    ColorVector = cat(1, noNaNValues);
                    color_background = char(sprintf("%d, %d, %d",ColorVector(1),ColorVector(2),ColorVector(3)));
                else
                    color_background = app.BackgroundColorDropDown.Value; % 바탕색
                end

                % Get the existing table data
                tableData = get(app.FullfieldIlluminationHistory, 'Data');

                % Append the new data to the existing table data
                newRow = {repetition, timeON, timeOFF, color_rectangle, color_background}; % Add more elements if needed for additional inputs
                newTableData = [tableData; newRow];
                
                % Update the table with the new data
                set(app.FullfieldIlluminationHistory, 'Data', newTableData);

            end % No recordings when switch is OFF

            %% Light stimulation
            for i=1:rep % Run illumination for "rep" number of repetitions
                drawnow; % Look for stopFlag = true
                if app.stopFlag == true % If STOP button pushed, loop will break and illumination will stop
                    break
                end
                drawnow;
                % Draw the dot to the screen
                Screen('FillRect', app.window, app.rectColor, app.centeredRect); % rectangle information
                Screen('Flip',app.window); % Display the rectangle on the screen
                % fwrite(s,0); % Sending a TTL pulse to MC_Card through RS232c

                % 자극 ON 시간 단위 (s, ms, μs) 설정
                if app.FullfieldIlluminationONDropDown.Value == "(s)"
                    WaitSecs(str2double(visTime));  % Pause for visTime seconds
                elseif app.FullfieldIlluminationONDropDown.Value == "(ms)"
                    WaitSecs(str2double(visTime)*(10^-3));  % Pause for visTime milliseconds
                elseif app.FullfieldIlluminationONDropDown.Value == "(μs)"
                    WaitSecs(str2double(visTime)*(10^-6));  % Pause for visTime microseconds
                end
                Screen('Flip',app.window);

                % 자극 OFF 시간 단위 (s, ms, μs) 설정
                if app.FullfieldIlluminationOFFDropDown.Value == "(s)"
                    WaitSecs(str2double(invisTime));
                elseif app.FullfieldIlluminationOFFDropDown.Value == "(ms)"
                    WaitSecs(str2double(invisTime)*(10^-3));
                elseif app.FullfieldIlluminationOFFDropDown.Value == "(μs)"
                    WaitSecs(str2double(invisTime)*(10^-6));
                end
            end
            Screen('FillRect',app.window, app.black, app.windowRect); % 자극 이후 배경색 검은색으로 복구
            Screen('Flip',app.window);
        end

        % Button pushed function: RunRandomCheckerboardIlluminationButton
        function RunRandomCheckerboardIlluminationButtonPushed(app, event)
            app.stopFlag = false; % unpause any paused illuminations
            %% Run pseudo-RandomCheckerboard illumination
            %% Positions of pseudo-RandomCheckerboard squares (Bernouli distribution)
            % Get the center coordinate of the window
            [app.xCenter, app.yCenter] = RectCenter(app.windowRect);

            % Number of rows and columns
            n = app.CheckerboardSizenxnSpinner.Value; % 자극 배열 설정
            dim = 1040/n; % Number of pixels per square = 1040/n
            % Make a base Rect of 200 by 200 pixels
            baseRect = [0 0 dim dim];
            g = n/2-0.5;
            % Make the coordinates for our grid of squares
            [xPos, yPos] = meshgrid(-g:1:g, -g:1:g);

            % Calculate the number of squares and reshape the matrices of coordinates into a vector
            [s1, s2] = size(xPos);
            numSquares = s1 * s2;
            xPos = reshape(xPos, 1, numSquares);
            yPos = reshape(yPos, 1, numSquares);

            % Scale the grid spacing to the size of our squares and center
            %xPosLeft = xPos .* dim + screenXpixels * 0.25;
            xPosLeft = xPos .* dim + app.xCenter;
            yPosLeft = yPos .* dim + app.yCenter;

            %xPosRight = xPos .* dim + screenXpixels * 0.75;
            %yPosRight = yPos .* dim + yCenter;

            % Make our rectangle coordinates
            allRectsLeft = nan(4, 3);
            %allRectsRight = nan(4, 3);
            for i = 1:numSquares
                allRectsLeft(:, i) = CenterRectOnPointd(baseRect,...
                    xPosLeft(i), yPosLeft(i));
                %allRectsRight(:, i) = CenterRectOnPointd(baseRect,...
                %    xPosRight(i), yPosRight(i));
            end
            %% Light stimulus protocol generation
            % 자극반복횟수 계산
            if app.RuntimeDropDown.Value == "(s)"
                rep = (app.FrequencyHzEditField.Value)*(app.RuntimeEditField.Value);
            elseif app.RuntimeDropDown.Value == "(min)"
                rep = (app.FrequencyHzEditField.Value)*(60)*(app.RuntimeEditField.Value);
            elseif app.RuntimeDropDown.Value == "(h)"
                rep = (app.FrequencyHzEditField.Value)*(60^2)*(app.RuntimeEditField.Value);
            end

            tot_rep = rep*(app.NumberofSetsSpinner.Value); % 패턴을 여러 세트 반복할 경우
            visTime = 1/(app.FrequencyHzEditField.Value); % 프레임당 자극 ON 시간
            invisTime = 0.03; % 자극 OFF 시간, unit: sec

            %% 자극 설정 기록
            if app.RecordCheckerboardHistorySwitch.Value == "On"
                boardsize = sprintf('%dx%d',app.CheckerboardSizenxnSpinner.Value, app.CheckerboardSizenxnSpinner.Value); % 자극 배열 정보
                if app.RuntimeDropDown.Value == "(s)" % 자극 시간 정보
                    runtime = sprintf('%d (s)',app.RuntimeEditField.Value);
                elseif app.RuntimeDropDown.Value == "(min)"
                    runtime = sprintf('%s (min)',app.RuntimeEditField.Value);
                elseif app.RuntimeDropDown.Value == "(h)"
                    runtime = sprintf('%s (h)',app.RuntimeEditField.Value);
                end
                frequency = app.FrequencyHzEditField.Value; % 자극 frequency 정보
                setNumber = app.NumberofSetsSpinner.Value; % 자극 세트수 정보

                % Get existing table data
                tableData = get(app.CheckerboardHistory, 'Data');

                % Append the new data to the existing table data
                newRow = {boardsize, runtime, frequency, setNumber}; % Elements compiled into new row
                newTableData = [tableData; newRow];

                % Update the table with the new data
                set(app.CheckerboardHistory, 'Data', newTableData);
            end
            %% StimInfo and Mat Setup
            StimInfo = {};
            %imageArray={};
            for i=1:rep
                RandMat=rand(n)<0.5; % Pseudo-RandomCheckerboard 자극생성
                RandMat=double(RandMat);
                RandMat = reshape(RandMat, 1, numSquares);
                RandMat = repmat(RandMat, 3, 1);
                %Screen('FillRect',window,RandMat,allRectsLeft); % Display the rectangle on the screen
                %Screen('Flip',window); % Display the rectangle on the screen
                %fwrite(s,0); % Sending a TTL pulse to MC_Card through RS232c
                %WaitSecs(visTime);  % Pause for visTime seconds
                StimInfo = [StimInfo; RandMat(1,:)];% Saving stimulus information in a matrix
                %imageArray = [imageArray; {Screen('GetImage', window, windowRect)}];% Produces a dynamic display and outputs an animated .gif record of the trial
                % Records the frame from front buffer and appends to the imageArray matrix
                % Assumes a screen resolution of 1024x768; alter the rect coordinates to change this
            end
            StimInfo = [StimInfo;StimInfo];
            Mat = {};
            %for k=1:rep
            for k=1:tot_rep
                Mat = [Mat; repmat(StimInfo{k}, 3, 1)];
            end

            %% Save StimInfo and Mat
            CurrentDate = datestr(datetime,'yyyymmdd HH_MM_SS'); % variable containing file name which is the current date
            Directories = {'Save Folder', 'Checkerboard Info', CurrentDate};
            for k = 1:length(Directories)
                thisDir = fullfile(Directories{1:k});
                mkdir(thisDir); % Makes new folder if 'Save Folder', 'Checkerboard Info', or CurrentDate Folder does not exist
            end
            StimInfoSave = StimInfo{1,1}; % variable containing matrix of first frame of checkerboard pattern in white(1) or black (0)
            MatSave = Mat{1,1}; % variable containing a 3xN matrix of first frame of checkerboard pattern in RGB

            % File title. Title will include the following:
            CBoardSize = (app.CheckerboardSizenxnSpinner.Value); % Checkerboard dimensions
            CBoardFreq = app.FrequencyHzEditField.Value; % Checkerboard frequency
            title=sprintf('%dx%d_%dHz',CBoardSize,CBoardSize,CBoardFreq);
            filePath = fullfile('Save Folder','Checkerboard Info', CurrentDate, [title, '.mat']);
            save(filePath,'StimInfoSave','MatSave'); % File made and saved in .mat format
            %% Light stimulation
            %for j=1:rep
            for j=1:tot_rep
                drawnow;% Look for stopFlag = true
                if app.stopFlag == true % If STOP button pushed, loop will break and illumination will stop
                    break
                end
                Screen('FillRect',app.window,Mat{j},allRectsLeft); % Display the rectangle on the screen
                Screen('Flip',app.window); % Display the rectangle on the screen
                %if j==1
                % fwrite(s,0); % Sending a TTL pulse to MC_Card through RS232c
                %end
                WaitSecs(visTime); % Pause for visTime seconds
            end
            Screen('Flip',app.window);
        end

        % Button pushed function: DoubleClicktoSTOPButton
        function DoubleClicktoSTOPButtonPushed(app, event)
            app.stopFlag = true; % Stimulation will stop when stopFlag is set to true
        end

        % Button pushed function: SaveFullfieldProtocolButton
        function SaveFullfieldProtocolButtonPushed(app, event)
            Directories = {'Save Folder', 'Protocols', 'Full-field Illumination Protocols'};
            for k = 1:length(Directories)
                thisDir = fullfile(Directories{1:k});
                mkdir(thisDir); % Makes new folder if 'Save Folder', 'Protocols', or 'Full-field Illumination Protocols' Folder does not exist
            end
            %%
            CurrentDate = datestr(datetime,'yyyymmdd'); % variable containing file name which is the current date

            dataToSave = app.FullfieldIlluminationHistory.Data;
            ProtocolFolder = fullfile('Save Folder','Protocols','Full-field Illumination Protocols');
            [fileName, filePath] = uiputfile('*.mat',sprintf('%s',CurrentDate),ProtocolFolder);
            if isequal(fileName, 0) || isequal(filePath, 0)
                % User canceled the save operation
                return;
            end
            fullfilePath = fullfile(filePath,fileName);
            save(fullfilePath, 'dataToSave')
        end

        % Button pushed function: LoadFullfieldProtocolButton
        function LoadFullfieldProtocolButtonPushed(app, event)
            ProtocolFolder = fullfile('Save Folder','Protocols','Full-field Illumination Protocols');
            [fileName, filePath] = uigetfile(ProtocolFolder); % Opens file explorer for user to selected protocol file
            if isequal(fileName, 0) || isequal(filePath, 0)
                % User canceled the load operation
                return;
            end
            % Combine the file name and path
            fullFilePath = fullfile(filePath, fileName);

            % Load the data from the selected MAT file
            loadedData = load(fullFilePath);
            % Assign the loaded table to the dataTable variable
            dataTable = loadedData.dataToSave;
            % Populate the table with the loaded data
            app.FullfieldIlluminationHistory.Data = dataTable;
        end

        % Button pushed function: SaveCheckerboardProtocolButton
        function SaveCheckerboardProtocolButtonPushed(app, event)
            Directories = {'Save Folder', 'Protocols', 'Checkerboard Protocols'};
            for k = 1:length(Directories)
                thisDir = fullfile(Directories{1:k});
                mkdir(thisDir); % Makes new folder if 'Save Folder', 'Protocols', or 'Checkerboard Protocols' Folder does not exist
            end
            %%
            CurrentDate = datestr(datetime,'yyyymmdd'); % variable containing file name which is the current date

            dataToSave = app.CheckerboardHistory.Data;
            ProtocolFolder = fullfile('Save Folder','Protocols','Checkerboard Protocols');
            [fileName, filePath] = uiputfile('*.mat', sprintf('%d Protocol',CurrentDate),ProtocolFolder);
            if isequal(fileName, 0) || isequal(filePath, 0)
                % User canceled the save operation
                return;
            end
            fullfilePath = fullfile(filePath,fileName);
            save(fullfilePath, 'dataToSave')
        end

        % Button pushed function: LoadCheckerboardProtocolButton
        function LoadCheckerboardProtocolButtonPushed(app, event)
            ProtocolFolder = fullfile('Save Folder','Protocols','Checkerboard Protocols');
            [fileName, filePath] = uigetfile(ProtocolFolder); % Opens file explorer for user to selected protocol file
            if isequal(fileName, 0) || isequal(filePath, 0)
                % User canceled the load operation
                return;
            end
            % Combine the file name and path
            fullFilePath = fullfile(filePath, fileName);

            % Load the data from the selected MAT file
            loadedData = load(fullFilePath);
            % Assign the loaded table to the dataTable variable
            dataTable = loadedData.dataToSave;
            % Populate the table with the loaded data
            app.CheckerboardHistory.Data = dataTable;
        end

        % Button pushed function: ClearFullfieldHistoryButton
        function ClearFullfieldHistoryButtonPushed(app, event)
            app.FullfieldIlluminationHistory.Data = []; % Clears table
        end

        % Button pushed function: ClearCheckerboardHistoryButton
        function ClearCheckerboardHistoryButtonPushed(app, event)
            app.CheckerboardHistory.Data = []; % Clears table
        end

        % Cell selection callback: FullfieldIlluminationHistory
        function FullfieldIlluminationHistoryCellSelection(app, event)
            indices = event.Indices;
            app.RowIndices_fullfield = indices; % Indices from selected row saved into property
        end

        % Cell selection callback: CheckerboardHistory
        function CheckerboardHistoryCellSelection(app, event)
            indices = event.Indices;
            app.RowIndices_checkerboard = indices; % Indices from selected row saved into property
        end

        % Menu selected function: DeleteRowMenu
        function DeleteRowMenuSelected(app, event)
            if length(app.RowIndices_fullfield) >= 1 % When a row has been selected
                SelectedRow = app.RowIndices_fullfield(1,1); % Row number found from selected indices
                app.FullfieldIlluminationHistory.Data(SelectedRow, :) = []; % Delete row from table
            else % When no row is selected
                return
            end
            app.RowIndices_fullfield = []; % Deselect row after deletion
        end

        % Menu selected function: DeleteRowMenu_2
        function DeleteRowMenu_2Selected(app, event)
            if length(app.RowIndices_checkerboard) >= 1 % When a row has been selected
                SelectedRow = app.RowIndices_checkerboard(1,1); % Row number found from selected indices
                app.CheckerboardHistory.Data(SelectedRow, :) = []; % Delete row from table
            else % When no row is selected
                return
            end
            app.RowIndices_checkerboard = []; % Deselect row after deletion
        end

        % Menu selected function: ApplySettingsMenu
        function ApplySettingsMenuSelected(app, event)
            SelectedRow = app.RowIndices_fullfield(1,1); % Row number found from selected indices
            % Apply repetition number setting
            app.FullfieldIlluminationRepetitionSpinner.Value = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,1));
            % Full-field illumination ON settings
            if contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2)), "(s)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (s)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationONEditField.Value = numExtract;
                app.FullfieldIlluminationONDropDown.Value = "(s)";
            elseif contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2)), "(ms)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (ms)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationONEditField.Value = numExtract;
                app.FullfieldIlluminationONDropDown.Value = "(ms)";
            elseif contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2)), "(μs)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (μs)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationONEditField.Value = numExtract;
                app.FullfieldIlluminationONDropDown.Value = "(μs)";
            end
            % Full-field illumination OFF settings
            if contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3)), "(s)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3));
                SplitMatrix = strsplit(Matrix, ' (s)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationOFFEditField.Value = numExtract;
                app.FullfieldIlluminationOFFDropDown.Value = "(s)";
            elseif contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3)), "(ms)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3));
                SplitMatrix = strsplit(Matrix, ' (ms)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationOFFEditField.Value = numExtract;
                app.FullfieldIlluminationOFFDropDown.Value = "(ms)";
            elseif contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3)), "(μs)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,3));
                SplitMatrix = strsplit(Matrix, ' (μs)');
                numExtract = sprintf('%d',str2double(SplitMatrix(1,1)));
                app.FullfieldIlluminationOFFEditField.Value = numExtract;
                app.FullfieldIlluminationOFFDropDown.Value = "(μs)";
            end
            % Apply rectangle color setting
            if contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,4)), "White"|"Black"|"Red"|"Green"|"Blue")
                app.FullfieldColorDropDown.Value = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,4));
                app.RGBEditField_rectColor.Visible = "off";
                app.RGBValue0255Label.Visible = "off";
            else
                app.FullfieldColorDropDown.Value = "Other";
                app.RGBEditField_rectColor.Value = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,4));
                app.RGBEditField_rectColor.Visible = "on";
                app.RGBValue0255Label.Visible = "on";
            end
            % Apply background color setting
            if contains(cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,5)), "White"|"Black"|"Red"|"Green"|"Blue")
                app.BackgroundColorDropDown.Value = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,5));
                app.RGBEditField_Background.Visible = "off";
                app.RGBValue0255EditFieldLabel.Visible = "off";
            else
                app.BackgroundColorDropDown.Value = "Other";
                app.RGBEditField_Background.Value = cell2mat(app.FullfieldIlluminationHistory.Data(SelectedRow,5));
                app.RGBEditField_Background.Visible = "on";
                app.RGBValue0255EditFieldLabel.Visible = "on";
            end
        end

        % Menu selected function: ApplySettingsMenu_2
        function ApplySettingsMenu_2Selected(app, event)
            SelectedRow = app.RowIndices_checkerboard(1,1); % Row number found from selected indices

            % Getting "n" from "nxn" cell
            Matrix = cell2mat(app.CheckerboardHistory.Data(SelectedRow,1)); % Convert cell into matrix
            SplitMatrix = strsplit(Matrix,'x'); % Results in ['n' 'n']
            numExtract = str2double(SplitMatrix(1,1)); % Converts 'n' into double
            app.CheckerboardSizenxnSpinner.Value  = numExtract; % Applies setting to spinner

            % Full-field illumination ON settings
            if contains(cell2mat(app.CheckerboardHistory.Data(SelectedRow,2)), "(s)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.CheckerboardHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (s)'); % for a cell containing "n (s)", this results in ['n']
                numExtract = str2double(SplitMatrix(1,1));
                app.RuntimeEditField.Value = numExtract;
                app.RuntimeDropDown.Value = "(s)";
            elseif contains(cell2mat(app.CheckerboardHistory.Data(SelectedRow,2)), "(min)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.CheckerboardHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (min)');
                numExtract = str2double(SplitMatrix(1,1)); % Results in ['n']
                app.RuntimeEditField.Value = numExtract;
                app.RuntimeDropDown.Value = "(min)";
            elseif contains(cell2mat(app.CheckerboardHistory.Data(SelectedRow,2)), "(h)")
                % Cell = table2array(app.FullfieldIlluminationHistory.Data(SelectedRow,2));
                Matrix = cell2mat(app.CheckerboardHistory.Data(SelectedRow,2));
                SplitMatrix = strsplit(Matrix, ' (h)');
                numExtract = str2double(SplitMatrix(1,1)); % Results in ['n']
                app.RuntimeEditField.Value = numExtract;
                app.RuntimeDropDown.Value = "(h)";
            end
            % Apply frequency setting
            app.FrequencyHzEditField.Value = cell2mat(app.CheckerboardHistory.Data(SelectedRow,3));
            % Apply set number setting
            app.NumberofSetsSpinner.Value = cell2mat(app.CheckerboardHistory.Data(SelectedRow,4));
        end

        % Button pushed function: OpenWindowButton_2
        function OpenWindowButton_2Pushed(app, event)
            %% Open an on screen window & Open the serial port
            app.black = [0 0 0];
            screens=Screen('Screens'); % Get the screen numbers
            app.screenNumber=max(screens); % Select the maximum of these numbers
            app.white=WhiteIndex(app.screenNumber); % Define white
            app.black=BlackIndex(app.screenNumber); % Define black
            % s=serial('COM1'); % Find serial port
            % set(s,'BaudRate',57600);

            [app.window,app.windowRect]=PsychImaging('OpenWindow',app.screenNumber,app.black); % Open an on screen window and color it black
            [app.screenXpixels,app.screenYpixels]=Screen('WindowSize',app.window); % Get the size of the on screen window in pixels
            % fopen(s); % Open the serial port

            %% Positions of Full-field illumination circle
            % Get the center coordinate of the window
            [app.xCenter, app.yCenter] = RectCenter(app.windowRect);
            % Make a base Rect of 200 by 200 pixels
            baseRect = [0 0 1200 1000];
            % Center the rectangle on the center of the screen
            app.centeredRect = CenterRectOnPointd(baseRect, app.xCenter, app.yCenter);
        end

        % Button pushed function: RunMovingBarIlluminationButton
        function RunMovingBarIlluminationButtonPushed(app, event)
            %% Moving bar
            % Query the frame duration
            ifi = Screen('GetFlipInterval', app.window);
            baseRect = [0 0 app.barWidth app.barLength];
            % Sync us and get a time stamp
            vbl = Screen('Flip', app.window);
            waitframes = 1;
            % Maximum priority level
            topPriorityLevel = MaxPriority(app.window);
            Priority(topPriorityLevel);
            rep=5; % 자극반복횟수
            %% Recording input settings on table
            % Record input values when switch is ON
            bar_angle = app.barAngle;
            width = app.barWidth * 1.65 / 1000;
            length = app.barLength * 1.65 / 1000;
            repetition = app.BarRepetitionSpinner.Value;
            velocity = app.BarVelocitymmsecEditField.Value;
            if app.RecordBarHistorySwitch.Value == "On"
                % Get the user input from some GUI components (e.g., edit boxes)
                if app.ButtonGroup.SelectedObject == app.StaticButton % 자극 ON 시간 단위 정보
                    movement = 'No';
                else
                    if app.selectedDirection == app.HorizontalNode || app.selectedDirection == app.VerticalNode || app.selectedDirection == app.DiagonalNode
                        movement = 'No';
                    else
                        movement = app.selectedDirection.Text;
                    end
                end

                if app.BarColorDropDown.Value == "Other"
                    rgbInput = app.RGBEditField_MovingBar.Value;
                    rgbValues = str2double(split(strrep(rgbInput, ' ', ','), ','));
                    noNaNValues = rgbValues(~isnan(rgbValues));
                    ColorVector = cat(1,noNaNValues)';
                    color_rectangle = char(sprintf("%d, %d, %d",ColorVector(1),ColorVector(2),ColorVector(3)));
                else
                    color_rectangle = app.BarColorDropDown.Value; % 가운데 사각형 색깔
                end       
                
                % Get the existing table data
                tableData = get(app.BarHistory, 'Data');

                % Append the new data to the existing table data
                newRow = {movement, bar_angle, width, length, color_rectangle, repetition, velocity}; % Add more elements if needed for additional inputs
                newTableData = [tableData; newRow];
                % Update the table with the new data
                set(app.BarHistory, 'Data', newTableData);

            end % No recordings when switch is OFF
            %% Moving Bar Protocol
            % Set defaults of parameters
            if app.ButtonGroup.SelectedObject == app.MoveButton
                if app.selectedDirection == app.LefttoRightNode || app.selectedDirection == app.RighttoLeftNode || app.selectedDirection == app.ToptoBottomNode || app.selectedDirection == app.BottomtoTopNode
                    movepix = 40*1000/66/60*app.barVelocity; % 40 pixel : 66 um = Moving distance (pixel) : 1000/60 (1 mm/초당, 막대이동속도)
                else
                    movepix = 40*1000/66/60/sqrt(2)*app.barVelocity; % 40 pixel : 66 um = Moving distance (pixel) : 1000/60 (1 mm/초당, 막대이동속도)
                end
            end
            n = 0;
            % fwrite(s,0); % Sending a TTL pulse to MC_Card through RS232c
            % Check if the StaticButton is selected
            if app.ButtonGroup.SelectedObject == app.StaticButton
                % Calculate the centered rectangle based on the screen center
                app.centeredRect = CenterRectOnPointd(baseRect, app.xCenter, app.yCenter);

                % Draw the rotated rectangle on the screen
                Screen('glPushMatrix', app.window);
                Screen('glTranslate', app.window, app.xCenter, app.yCenter); % Apply translation
                Screen('glRotate', app.window, app.barAngle, 0, 0); % Apply rotation around the origin
                Screen('FillRect', app.window, app.barColor, CenterRectOnPointd([0 0 app.barWidth app.barLength], 0, 0)); % Adjusted dimensions
                Screen('glPopMatrix', app.window);

                % Flip to display the rotated rectangle
                Screen('Flip', app.window);

                % Wait for a certain duration (e.g., 1 second)
                KbWait;

                % Clear the screen (restore background color)
                Screen('FillRect', app.window, app.black, app.windowRect);
            else
                for i = 1:app.BarRepetitionSpinner.Value
                    if app.selectedDirection == app.LefttoRightNode
                        BarFunc(app, 0, app.yCenter, 1, 0, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.RighttoLeftNode
                        BarFunc(app, app.screenXpixels, app.yCenter, -1, 0, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.ToptoBottomNode
                        BarFunc(app, app.xCenter, 0, 0, 1, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.BottomtoTopNode
                        BarFunc(app, app.xCenter, app.screenYpixels, 0, -1, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.TopLefttoBottomRightNode
                        BarFunc(app, 0, 0, 1, 1, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.BottomLefttoTopRightNode
                        BarFunc(app, 0, app.screenYpixels, 1, -1, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.TopRIghttoBottomLeftNode
                        BarFunc(app, app.screenXpixels, 0, -1, 1, n, movepix, baseRect, vbl, waitframes, ifi)
                    elseif app.selectedDirection == app.BottomRighttoTopLeftNode
                        BarFunc(app, app.screenXpixels, app.screenYpixels, -1, -1, n, movepix, baseRect, vbl, waitframes, ifi)
                    else
                        break
                    end
                end
            end
            Screen('Flip',app.window);
        end

        % Value changed function: FullfieldColorDropDown
        function FullfieldColorDropDownValueChanged(app, event)
            value = app.FullfieldColorDropDown.Value;
            % rectColor set based on user input
            if app.FullfieldColorDropDown.Value == "White"
                app.rectColor = [1 1 1];
            elseif app.FullfieldColorDropDown.Value == "Black"
                app.rectColor = [0 0 0];
            elseif app.FullfieldColorDropDown.Value == "Red"
                app.rectColor = [1 0 0];
            elseif app.FullfieldColorDropDown.Value == "Green"
                app.rectColor = [0 1 0];
            elseif app.FullfieldColorDropDown.Value == "Blue"
                app.rectColor = [0 0 1];
            elseif app.FullfieldColorDropDown.Value == "Other"
                ColorFunc(app, value)
                app.rectColor = app.funcResult;
            end
            if contains(value, "Other")
                app.RGBEditField_rectColor.Visible = "on";
                app.RGBValue0255Label.Visible = "on";
            else
                app.RGBEditField_rectColor.Visible = "off";
                app.RGBValue0255Label.Visible = "off";
            end
        end

        % Value changed function: BackgroundColorDropDown
        function BackgroundColorDropDownValueChanged(app, event)
            value = app.BackgroundColorDropDown.Value;
            % Background windows color set based on user input
            if app.BackgroundColorDropDown.Value == "Black"
                app.WindowColor = [0 0 0];
            elseif app.BackgroundColorDropDown.Value == "White"
                app.WindowColor = [1 1 1];
            elseif app.BackgroundColorDropDown.Value == "Red"
                app.WindowColor = [1 0 0];
            elseif app.BackgroundColorDropDown.Value == "Green"
                app.WindowColor = [0 1 0];
            elseif app.BackgroundColorDropDown.Value == "Blue"
                app.WindowColor = [0 0 1];
            elseif app.BackgroundColorDropDown.Value == "Other"
                ColorFunc(app, value)
                app.WindowColor = app.funcResult;
            end
            if contains(value, "Other")
                app.RGBEditField_Background.Visible = "on";
                app.RGBValue0255EditFieldLabel.Visible = "on";
            else
                app.RGBEditField_Background.Visible = "off";
                app.RGBValue0255EditFieldLabel.Visible = "off";
            end
        end

        % Value changed function: BarColorDropDown
        function BarColorDropDownValueChanged(app, event)
            value = app.BarColorDropDown.Value;
            if contains(value, "Other")
                app.RGBEditField_MovingBar.Visible = "on";
                app.RGBValues0255Label.Visible = "on";
            else
                app.RGBEditField_MovingBar.Visible = "off";
                app.RGBValues0255Label.Visible = "off";
            end
             % rectColor set based on user input
            if value == "White"
                app.barColor = [1 1 1];
            elseif value == "Black"
                app.barColor = [0 0 0];
            elseif value == "Red"
                app.barColor = [1 0 0];
            elseif value == "Green"
                app.barColor = [0 1 0];
            elseif value == "Blue"
                app.barColor = [0 0 1];
            elseif value == "Other"
                ColorFunc(app, value)
                app.barColor = app.funcResult;
            end
        end

        % Value changed function: RGBEditField_rectColor
        function RGBEditField_rectColorValueChanged(app, event)
            value = app.RGBEditField_rectColor.Value;
            if app.FullfieldColorDropDown.Value == "Other"
                ColorFunc(app, value)
                app.rectColor = app.funcResult;
            end
        end

        % Value changed function: RGBEditField_Background
        function RGBEditField_BackgroundValueChanged(app, event)
            value = app.RGBEditField_Background.Value;
            if app.FullfieldColorDropDown.Value == "Other"
                ColorFunc(app, value)
                app.WindowColor = app.funcResult;
            end
        end

        % Value changed function: RGBEditField_MovingBar
        function RGBEditField_MovingBarValueChanged(app, event)
            value = app.RGBEditField_MovingBar.Value;
            if app.BarColorDropDown.Value == "Other"
                ColorFunc(app, value)
                app.barColor = app.funcResult;
            end
        end

        % Value changed function: BarAngleEditField
        function BarAngleEditFieldValueChanged(app, event)
            value = app.BarAngleEditField.Value;
            app.barAngle=value;
        end

        % Value changed function: BarWidthmmEditField
        function BarWidthmmEditFieldValueChanged(app, event)
            value = 1000 / 1.65 * (app.BarWidthmmEditField.Value);
            app.barWidth = value;
        end

        % Value changed function: BarLengthmmEditField
        function BarLengthmmEditFieldValueChanged(app, event)
            value = 1000 / 1.65 * (app.BarLengthmmEditField.Value);
            app.barLength = value;
        end

        % Selection changed function: Tree
        function TreeSelectionChanged(app, event)
            selectedNodes = app.Tree.SelectedNodes;
            app.selectedDirection = selectedNodes;
        end

        % Selection changed function: ButtonGroup
        function ButtonGroupSelectionChanged(app, event)
            selectedButton = app.ButtonGroup.SelectedObject;
            if selectedButton == app.MoveButton
                app.Tree.FontColor = [0 0 0];
                app.BarRepetitionSpinner.FontColor = [0 0 0];
                app.BarRepetitionSpinnerLabel.FontColor = [0 0 0];
                app.BarVelocitymmsecEditField.FontColor = [0 0 0];
                app.BarVelocitymmsecEditFieldLabel.FontColor = [0 0 0];
            else
                app.Tree.FontColor = [0.65 0.65 0.65];
                app.BarRepetitionSpinner.FontColor = [0.65 0.65 0.65];
                app.BarRepetitionSpinnerLabel.FontColor = [0.65 0.65 0.65];
                app.BarVelocitymmsecEditField.FontColor = [0.65 0.65 0.65];
                app.BarVelocitymmsecEditFieldLabel.FontColor = [0.65 0.65 0.65];
            end
        end

        % Value changed function: BarVelocitymmsecEditField
        function BarVelocitymmsecEditFieldValueChanged(app, event)
            value = app.BarVelocitymmsecEditField.Value;
            app.barVelocity = value;            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 936 634];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 936 633];

            % Create FullfieldCheckerboardTab
            app.FullfieldCheckerboardTab = uitab(app.TabGroup);
            app.FullfieldCheckerboardTab.Title = 'Full-field & Checkerboard';

            % Create OpenWindowButton
            app.OpenWindowButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.OpenWindowButton.ButtonPushedFcn = createCallbackFcn(app, @OpenWindowButtonPushed, true);
            app.OpenWindowButton.Position = [14 555 100 23];
            app.OpenWindowButton.Text = 'Open Window';

            % Create CheckerboardHistory
            app.CheckerboardHistory = uitable(app.FullfieldCheckerboardTab);
            app.CheckerboardHistory.ColumnName = {'Board Size'; 'Runtime'; 'Frequency'; 'Number of Sets'};
            app.CheckerboardHistory.RowName = {};
            app.CheckerboardHistory.SelectionType = 'row';
            app.CheckerboardHistory.CellSelectionCallback = createCallbackFcn(app, @CheckerboardHistoryCellSelection, true);
            app.CheckerboardHistory.Position = [540 49 369 153];

            % Create FullfieldIlluminationHistory
            app.FullfieldIlluminationHistory = uitable(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationHistory.ColumnName = {'Repetition'; 'Time ON'; 'Time OFF'; 'Color'; 'Background'};
            app.FullfieldIlluminationHistory.RowName = {};
            app.FullfieldIlluminationHistory.SelectionType = 'row';
            app.FullfieldIlluminationHistory.CellSelectionCallback = createCallbackFcn(app, @FullfieldIlluminationHistoryCellSelection, true);
            app.FullfieldIlluminationHistory.Position = [460 321 448 185];

            % Create DoubleClicktoSTOPButton
            app.DoubleClicktoSTOPButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.DoubleClicktoSTOPButton.ButtonPushedFcn = createCallbackFcn(app, @DoubleClicktoSTOPButtonPushed, true);
            app.DoubleClicktoSTOPButton.Position = [777 555 132 23];
            app.DoubleClicktoSTOPButton.Text = 'Double Click to STOP';

            % Create FullfieldIlluminationONDropDown
            app.FullfieldIlluminationONDropDown = uidropdown(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationONDropDown.Items = {'(s)', '(ms)', '(μs)'};
            app.FullfieldIlluminationONDropDown.FontWeight = 'bold';
            app.FullfieldIlluminationONDropDown.Position = [271 451 60 22];
            app.FullfieldIlluminationONDropDown.Value = '(s)';

            % Create FullfieldIlluminationOFFDropDown
            app.FullfieldIlluminationOFFDropDown = uidropdown(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationOFFDropDown.Items = {'(s)', '(ms)', '(μs)'};
            app.FullfieldIlluminationOFFDropDown.FontWeight = 'bold';
            app.FullfieldIlluminationOFFDropDown.Position = [276 422 61 22];
            app.FullfieldIlluminationOFFDropDown.Value = '(s)';

            % Create RuntimeDropDown
            app.RuntimeDropDown = uidropdown(app.FullfieldCheckerboardTab);
            app.RuntimeDropDown.Items = {'(s)', '(min)', '(h)'};
            app.RuntimeDropDown.FontWeight = 'bold';
            app.RuntimeDropDown.Position = [134 155 72 22];
            app.RuntimeDropDown.Value = '(s)';

            % Create SaveFullfieldProtocolButton
            app.SaveFullfieldProtocolButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.SaveFullfieldProtocolButton.ButtonPushedFcn = createCallbackFcn(app, @SaveFullfieldProtocolButtonPushed, true);
            app.SaveFullfieldProtocolButton.Position = [809 292 100 23];
            app.SaveFullfieldProtocolButton.Text = 'Save Protocol';

            % Create ClearFullfieldHistoryButton
            app.ClearFullfieldHistoryButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.ClearFullfieldHistoryButton.ButtonPushedFcn = createCallbackFcn(app, @ClearFullfieldHistoryButtonPushed, true);
            app.ClearFullfieldHistoryButton.Position = [795 509 114 23];
            app.ClearFullfieldHistoryButton.Text = 'Clear Input History';

            % Create LoadFullfieldProtocolButton
            app.LoadFullfieldProtocolButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.LoadFullfieldProtocolButton.ButtonPushedFcn = createCallbackFcn(app, @LoadFullfieldProtocolButtonPushed, true);
            app.LoadFullfieldProtocolButton.Position = [701 292 100 23];
            app.LoadFullfieldProtocolButton.Text = 'Load Protocol';

            % Create SaveCheckerboardProtocolButton
            app.SaveCheckerboardProtocolButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.SaveCheckerboardProtocolButton.ButtonPushedFcn = createCallbackFcn(app, @SaveCheckerboardProtocolButtonPushed, true);
            app.SaveCheckerboardProtocolButton.Position = [809 18 100 23];
            app.SaveCheckerboardProtocolButton.Text = 'Save Protocol';

            % Create LoadCheckerboardProtocolButton
            app.LoadCheckerboardProtocolButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.LoadCheckerboardProtocolButton.ButtonPushedFcn = createCallbackFcn(app, @LoadCheckerboardProtocolButtonPushed, true);
            app.LoadCheckerboardProtocolButton.Position = [701 18 100 23];
            app.LoadCheckerboardProtocolButton.Text = 'Load Protocol';

            % Create ClearCheckerboardHistoryButton
            app.ClearCheckerboardHistoryButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.ClearCheckerboardHistoryButton.ButtonPushedFcn = createCallbackFcn(app, @ClearCheckerboardHistoryButtonPushed, true);
            app.ClearCheckerboardHistoryButton.Position = [794 205 114 23];
            app.ClearCheckerboardHistoryButton.Text = 'Clear Input History';

            % Create FullfieldIlluminationLabel
            app.FullfieldIlluminationLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationLabel.FontSize = 18;
            app.FullfieldIlluminationLabel.FontWeight = 'bold';
            app.FullfieldIlluminationLabel.FontAngle = 'italic';
            app.FullfieldIlluminationLabel.Position = [16 509 186 23];
            app.FullfieldIlluminationLabel.Text = 'Full-field Illumination';

            % Create RandomCheckerboardIlluminationLabel
            app.RandomCheckerboardIlluminationLabel = uilabel(app.FullfieldCheckerboardTab);
            app.RandomCheckerboardIlluminationLabel.FontSize = 18;
            app.RandomCheckerboardIlluminationLabel.FontWeight = 'bold';
            app.RandomCheckerboardIlluminationLabel.FontAngle = 'italic';
            app.RandomCheckerboardIlluminationLabel.Position = [10 227 313 23];
            app.RandomCheckerboardIlluminationLabel.Text = 'Random Checkerboard Illumination';

            % Create RecordInputHistoryLabel
            app.RecordInputHistoryLabel = uilabel(app.FullfieldCheckerboardTab);
            app.RecordInputHistoryLabel.HorizontalAlignment = 'center';
            app.RecordInputHistoryLabel.Position = [367 321 114 32];
            app.RecordInputHistoryLabel.Text = {'Record Input '; 'History'};

            % Create RecordFullfieldHistorySwitch
            app.RecordFullfieldHistorySwitch = uiswitch(app.FullfieldCheckerboardTab, 'slider');
            app.RecordFullfieldHistorySwitch.Orientation = 'vertical';
            app.RecordFullfieldHistorySwitch.Position = [414 380 20 45];
            app.RecordFullfieldHistorySwitch.Value = 'On';

            % Create RecordInputHistoryLabel_2
            app.RecordInputHistoryLabel_2 = uilabel(app.FullfieldCheckerboardTab);
            app.RecordInputHistoryLabel_2.HorizontalAlignment = 'center';
            app.RecordInputHistoryLabel_2.Position = [463 40 77 30];
            app.RecordInputHistoryLabel_2.Text = {'Record Input '; 'History'};

            % Create RecordCheckerboardHistorySwitch
            app.RecordCheckerboardHistorySwitch = uiswitch(app.FullfieldCheckerboardTab, 'slider');
            app.RecordCheckerboardHistorySwitch.Orientation = 'vertical';
            app.RecordCheckerboardHistorySwitch.Position = [490 96 20 45];
            app.RecordCheckerboardHistorySwitch.Value = 'On';

            % Create FullfieldIlluminationRepetitionSpinnerLabel
            app.FullfieldIlluminationRepetitionSpinnerLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationRepetitionSpinnerLabel.HorizontalAlignment = 'right';
            app.FullfieldIlluminationRepetitionSpinnerLabel.Position = [13 479 172 22];
            app.FullfieldIlluminationRepetitionSpinnerLabel.Text = 'Full-field Illumination Repetition';

            % Create FullfieldIlluminationRepetitionSpinner
            app.FullfieldIlluminationRepetitionSpinner = uispinner(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationRepetitionSpinner.Position = [200 479 100 22];
            app.FullfieldIlluminationRepetitionSpinner.Value = 10;

            % Create FullfieldIlluminationONEditFieldLabel
            app.FullfieldIlluminationONEditFieldLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationONEditFieldLabel.HorizontalAlignment = 'right';
            app.FullfieldIlluminationONEditFieldLabel.Position = [12 451 139 22];
            app.FullfieldIlluminationONEditFieldLabel.Text = 'Full-field Illumination ON ';

            % Create FullfieldIlluminationONEditField
            app.FullfieldIlluminationONEditField = uieditfield(app.FullfieldCheckerboardTab, 'text');
            app.FullfieldIlluminationONEditField.Position = [166 451 100 22];
            app.FullfieldIlluminationONEditField.Value = '4';

            % Create FullfieldIlluminationOFFEditFieldLabel
            app.FullfieldIlluminationOFFEditFieldLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FullfieldIlluminationOFFEditFieldLabel.HorizontalAlignment = 'right';
            app.FullfieldIlluminationOFFEditFieldLabel.Position = [12 422 142 22];
            app.FullfieldIlluminationOFFEditFieldLabel.Text = 'Full-field Illumination OFF';

            % Create FullfieldIlluminationOFFEditField
            app.FullfieldIlluminationOFFEditField = uieditfield(app.FullfieldCheckerboardTab, 'text');
            app.FullfieldIlluminationOFFEditField.Position = [169 422 100 22];
            app.FullfieldIlluminationOFFEditField.Value = '4';

            % Create FullfieldColorDropDownLabel
            app.FullfieldColorDropDownLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FullfieldColorDropDownLabel.HorizontalAlignment = 'right';
            app.FullfieldColorDropDownLabel.Position = [15 395 82 22];
            app.FullfieldColorDropDownLabel.Text = 'Full-field Color';

            % Create FullfieldColorDropDown
            app.FullfieldColorDropDown = uidropdown(app.FullfieldCheckerboardTab);
            app.FullfieldColorDropDown.Items = {'White', 'Black', 'Red', 'Green', 'Blue', 'Other'};
            app.FullfieldColorDropDown.ValueChangedFcn = createCallbackFcn(app, @FullfieldColorDropDownValueChanged, true);
            app.FullfieldColorDropDown.Position = [112 395 100 22];
            app.FullfieldColorDropDown.Value = 'White';

            % Create BackgroundColorDropDownLabel
            app.BackgroundColorDropDownLabel = uilabel(app.FullfieldCheckerboardTab);
            app.BackgroundColorDropDownLabel.HorizontalAlignment = 'right';
            app.BackgroundColorDropDownLabel.Position = [14 367 101 22];
            app.BackgroundColorDropDownLabel.Text = 'Background Color';

            % Create BackgroundColorDropDown
            app.BackgroundColorDropDown = uidropdown(app.FullfieldCheckerboardTab);
            app.BackgroundColorDropDown.Items = {'Black', 'White', 'Red', 'Green', 'Blue', 'Other'};
            app.BackgroundColorDropDown.ValueChangedFcn = createCallbackFcn(app, @BackgroundColorDropDownValueChanged, true);
            app.BackgroundColorDropDown.Position = [130 367 100 22];
            app.BackgroundColorDropDown.Value = 'Black';

            % Create RunFullfieldIlluminationButton
            app.RunFullfieldIlluminationButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.RunFullfieldIlluminationButton.ButtonPushedFcn = createCallbackFcn(app, @RunFullfieldIlluminationButtonPushed, true);
            app.RunFullfieldIlluminationButton.Position = [18 326 150 23];
            app.RunFullfieldIlluminationButton.Text = 'Run Full-field Illumination';

            % Create CheckerboardSizenxnSpinnerLabel
            app.CheckerboardSizenxnSpinnerLabel = uilabel(app.FullfieldCheckerboardTab);
            app.CheckerboardSizenxnSpinnerLabel.HorizontalAlignment = 'right';
            app.CheckerboardSizenxnSpinnerLabel.Position = [14 185 138 22];
            app.CheckerboardSizenxnSpinnerLabel.Text = 'Checkerboard Size (nxn)';

            % Create CheckerboardSizenxnSpinner
            app.CheckerboardSizenxnSpinner = uispinner(app.FullfieldCheckerboardTab);
            app.CheckerboardSizenxnSpinner.Position = [167 185 100 22];
            app.CheckerboardSizenxnSpinner.Value = 8;

            % Create RuntimeEditFieldLabel
            app.RuntimeEditFieldLabel = uilabel(app.FullfieldCheckerboardTab);
            app.RuntimeEditFieldLabel.HorizontalAlignment = 'right';
            app.RuntimeEditFieldLabel.Position = [16 155 53 22];
            app.RuntimeEditFieldLabel.Text = 'Runtime ';

            % Create RuntimeEditField
            app.RuntimeEditField = uieditfield(app.FullfieldCheckerboardTab, 'numeric');
            app.RuntimeEditField.Position = [84 155 46 22];
            app.RuntimeEditField.Value = 1;

            % Create FrequencyHzEditFieldLabel
            app.FrequencyHzEditFieldLabel = uilabel(app.FullfieldCheckerboardTab);
            app.FrequencyHzEditFieldLabel.HorizontalAlignment = 'right';
            app.FrequencyHzEditFieldLabel.Position = [16 124 88 22];
            app.FrequencyHzEditFieldLabel.Text = 'Frequency (Hz)';

            % Create FrequencyHzEditField
            app.FrequencyHzEditField = uieditfield(app.FullfieldCheckerboardTab, 'numeric');
            app.FrequencyHzEditField.Position = [119 124 100 22];
            app.FrequencyHzEditField.Value = 10;

            % Create NumberofSetsSpinnerLabel
            app.NumberofSetsSpinnerLabel = uilabel(app.FullfieldCheckerboardTab);
            app.NumberofSetsSpinnerLabel.HorizontalAlignment = 'right';
            app.NumberofSetsSpinnerLabel.Position = [17 95 88 22];
            app.NumberofSetsSpinnerLabel.Text = 'Number of Sets';

            % Create NumberofSetsSpinner
            app.NumberofSetsSpinner = uispinner(app.FullfieldCheckerboardTab);
            app.NumberofSetsSpinner.Position = [120 95 100 22];
            app.NumberofSetsSpinner.Value = 1;

            % Create RunRandomCheckerboardIlluminationButton
            app.RunRandomCheckerboardIlluminationButton = uibutton(app.FullfieldCheckerboardTab, 'push');
            app.RunRandomCheckerboardIlluminationButton.ButtonPushedFcn = createCallbackFcn(app, @RunRandomCheckerboardIlluminationButtonPushed, true);
            app.RunRandomCheckerboardIlluminationButton.Position = [10 43 230 23];
            app.RunRandomCheckerboardIlluminationButton.Text = 'Run Random Checkerboard Illumination';

            % Create RGBValue0255Label
            app.RGBValue0255Label = uilabel(app.FullfieldCheckerboardTab);
            app.RGBValue0255Label.FontSize = 10;
            app.RGBValue0255Label.Visible = 'off';
            app.RGBValue0255Label.Position = [319 387 54 25];
            app.RGBValue0255Label.Text = {'RGB Value'; '(0-255)'};

            % Create RGBEditField_rectColor
            app.RGBEditField_rectColor = uieditfield(app.FullfieldCheckerboardTab, 'text');
            app.RGBEditField_rectColor.ValueChangedFcn = createCallbackFcn(app, @RGBEditField_rectColorValueChanged, true);
            app.RGBEditField_rectColor.Visible = 'off';
            app.RGBEditField_rectColor.Position = [216 395 100 22];
            app.RGBEditField_rectColor.Value = 'Red, Green, Blue';

            % Create RGBValue0255EditFieldLabel
            app.RGBValue0255EditFieldLabel = uilabel(app.FullfieldCheckerboardTab);
            app.RGBValue0255EditFieldLabel.FontSize = 10;
            app.RGBValue0255EditFieldLabel.Visible = 'off';
            app.RGBValue0255EditFieldLabel.Position = [337 360 54 25];
            app.RGBValue0255EditFieldLabel.Text = {'RGB Value'; '(0-255)'};

            % Create RGBEditField_Background
            app.RGBEditField_Background = uieditfield(app.FullfieldCheckerboardTab, 'text');
            app.RGBEditField_Background.ValueChangedFcn = createCallbackFcn(app, @RGBEditField_BackgroundValueChanged, true);
            app.RGBEditField_Background.Visible = 'off';
            app.RGBEditField_Background.Position = [234 367 100 22];
            app.RGBEditField_Background.Value = 'Red, Green, Blue';

            % Create MovingBarTab
            app.MovingBarTab = uitab(app.TabGroup);
            app.MovingBarTab.Title = 'Moving Bar';

            % Create OpenWindowButton_2
            app.OpenWindowButton_2 = uibutton(app.MovingBarTab, 'push');
            app.OpenWindowButton_2.ButtonPushedFcn = createCallbackFcn(app, @OpenWindowButton_2Pushed, true);
            app.OpenWindowButton_2.Position = [14 555 100 23];
            app.OpenWindowButton_2.Text = 'Open Window';

            % Create MovingBarIlluminationLabel
            app.MovingBarIlluminationLabel = uilabel(app.MovingBarTab);
            app.MovingBarIlluminationLabel.FontSize = 18;
            app.MovingBarIlluminationLabel.FontWeight = 'bold';
            app.MovingBarIlluminationLabel.FontAngle = 'italic';
            app.MovingBarIlluminationLabel.Position = [15 497 210 23];
            app.MovingBarIlluminationLabel.Text = 'Moving Bar Illumination';

            % Create RunMovingBarIlluminationButton
            app.RunMovingBarIlluminationButton = uibutton(app.MovingBarTab, 'push');
            app.RunMovingBarIlluminationButton.ButtonPushedFcn = createCallbackFcn(app, @RunMovingBarIlluminationButtonPushed, true);
            app.RunMovingBarIlluminationButton.Position = [293 230 165 23];
            app.RunMovingBarIlluminationButton.Text = 'Run Moving Bar Illumination';

            % Create BarAngleLabel
            app.BarAngleLabel = uilabel(app.MovingBarTab);
            app.BarAngleLabel.HorizontalAlignment = 'right';
            app.BarAngleLabel.Position = [61 450 77 22];
            app.BarAngleLabel.Text = 'Bar Angle ( °)';

            % Create BarAngleEditField
            app.BarAngleEditField = uieditfield(app.MovingBarTab, 'numeric');
            app.BarAngleEditField.ValueChangedFcn = createCallbackFcn(app, @BarAngleEditFieldValueChanged, true);
            app.BarAngleEditField.Position = [153 450 100 22];
            app.BarAngleEditField.Value = 135;

            % Create BarWidthmmEditFieldLabel
            app.BarWidthmmEditFieldLabel = uilabel(app.MovingBarTab);
            app.BarWidthmmEditFieldLabel.HorizontalAlignment = 'right';
            app.BarWidthmmEditFieldLabel.Position = [49 420 89 22];
            app.BarWidthmmEditFieldLabel.Text = 'Bar Width (mm)';

            % Create BarWidthmmEditField
            app.BarWidthmmEditField = uieditfield(app.MovingBarTab, 'numeric');
            app.BarWidthmmEditField.ValueChangedFcn = createCallbackFcn(app, @BarWidthmmEditFieldValueChanged, true);
            app.BarWidthmmEditField.Position = [153 420 100 22];
            app.BarWidthmmEditField.Value = 0.3;

            % Create BarColorDropDownLabel
            app.BarColorDropDownLabel = uilabel(app.MovingBarTab);
            app.BarColorDropDownLabel.HorizontalAlignment = 'right';
            app.BarColorDropDownLabel.Position = [81 361 56 22];
            app.BarColorDropDownLabel.Text = 'Bar Color';

            % Create BarColorDropDown
            app.BarColorDropDown = uidropdown(app.MovingBarTab);
            app.BarColorDropDown.Items = {'White', 'Black', 'Red', 'Green', 'Blue', 'Other'};
            app.BarColorDropDown.ValueChangedFcn = createCallbackFcn(app, @BarColorDropDownValueChanged, true);
            app.BarColorDropDown.Position = [152 361 100 22];
            app.BarColorDropDown.Value = 'White';

            % Create RGBValues0255Label
            app.RGBValues0255Label = uilabel(app.MovingBarTab);
            app.RGBValues0255Label.FontSize = 10;
            app.RGBValues0255Label.Visible = 'off';
            app.RGBValues0255Label.Position = [366 352 59 25];
            app.RGBValues0255Label.Text = {'RGB Values'; '(0-255)'};

            % Create RGBEditField_MovingBar
            app.RGBEditField_MovingBar = uieditfield(app.MovingBarTab, 'text');
            app.RGBEditField_MovingBar.ValueChangedFcn = createCallbackFcn(app, @RGBEditField_MovingBarValueChanged, true);
            app.RGBEditField_MovingBar.Visible = 'off';
            app.RGBEditField_MovingBar.Position = [259 361 104 22];
            app.RGBEditField_MovingBar.Value = 'Red, Green, Blue';

            % Create BarLengthmmEditFieldLabel
            app.BarLengthmmEditFieldLabel = uilabel(app.MovingBarTab);
            app.BarLengthmmEditFieldLabel.HorizontalAlignment = 'right';
            app.BarLengthmmEditFieldLabel.Position = [43 391 95 22];
            app.BarLengthmmEditFieldLabel.Text = 'Bar Length (mm)';

            % Create BarLengthmmEditField
            app.BarLengthmmEditField = uieditfield(app.MovingBarTab, 'numeric');
            app.BarLengthmmEditField.ValueChangedFcn = createCallbackFcn(app, @BarLengthmmEditFieldValueChanged, true);
            app.BarLengthmmEditField.Position = [153 391 100 22];
            app.BarLengthmmEditField.Value = 1.65;

            % Create ButtonGroup
            app.ButtonGroup = uibuttongroup(app.MovingBarTab);
            app.ButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupSelectionChanged, true);
            app.ButtonGroup.Position = [126 234 123 52];

            % Create StaticButton
            app.StaticButton = uiradiobutton(app.ButtonGroup);
            app.StaticButton.Text = 'Static';
            app.StaticButton.Position = [11 26 58 22];
            app.StaticButton.Value = true;

            % Create MoveButton
            app.MoveButton = uiradiobutton(app.ButtonGroup);
            app.MoveButton.Text = 'Move';
            app.MoveButton.Position = [11 4 65 22];

            % Create Tree
            app.Tree = uitree(app.MovingBarTab);
            app.Tree.SelectionChangedFcn = createCallbackFcn(app, @TreeSelectionChanged, true);
            app.Tree.Position = [68 74 182 157];

            % Create HorizontalNode
            app.HorizontalNode = uitreenode(app.Tree);
            app.HorizontalNode.Text = 'Horizontal';

            % Create LefttoRightNode
            app.LefttoRightNode = uitreenode(app.HorizontalNode);
            app.LefttoRightNode.Text = 'Left to Right';

            % Create RighttoLeftNode
            app.RighttoLeftNode = uitreenode(app.HorizontalNode);
            app.RighttoLeftNode.Text = 'Right to Left';

            % Create VerticalNode
            app.VerticalNode = uitreenode(app.Tree);
            app.VerticalNode.Text = 'Vertical';

            % Create ToptoBottomNode
            app.ToptoBottomNode = uitreenode(app.VerticalNode);
            app.ToptoBottomNode.Text = 'Top to Bottom';

            % Create BottomtoTopNode
            app.BottomtoTopNode = uitreenode(app.VerticalNode);
            app.BottomtoTopNode.Text = 'Bottom to Top';

            % Create DiagonalNode
            app.DiagonalNode = uitreenode(app.Tree);
            app.DiagonalNode.Text = 'Diagonal';

            % Create TopLefttoBottomRightNode
            app.TopLefttoBottomRightNode = uitreenode(app.DiagonalNode);
            app.TopLefttoBottomRightNode.Text = 'Top Left to Bottom Right';

            % Create BottomLefttoTopRightNode
            app.BottomLefttoTopRightNode = uitreenode(app.DiagonalNode);
            app.BottomLefttoTopRightNode.Text = 'Bottom Left to Top Right';

            % Create TopRIghttoBottomLeftNode
            app.TopRIghttoBottomLeftNode = uitreenode(app.DiagonalNode);
            app.TopRIghttoBottomLeftNode.Text = 'Top RIght to Bottom Left';

            % Create BottomRighttoTopLeftNode
            app.BottomRighttoTopLeftNode = uitreenode(app.DiagonalNode);
            app.BottomRighttoTopLeftNode.Text = 'Bottom Right to Top Left';

            % Create BarRepetitionSpinnerLabel
            app.BarRepetitionSpinnerLabel = uilabel(app.MovingBarTab);
            app.BarRepetitionSpinnerLabel.HorizontalAlignment = 'right';
            app.BarRepetitionSpinnerLabel.Position = [56 331 81 22];
            app.BarRepetitionSpinnerLabel.Text = 'Bar Repetition';

            % Create BarRepetitionSpinner
            app.BarRepetitionSpinner = uispinner(app.MovingBarTab);
            app.BarRepetitionSpinner.Position = [152 331 100 22];
            app.BarRepetitionSpinner.Value = 1;

            % Create BarVelocitymmsecEditFieldLabel
            app.BarVelocitymmsecEditFieldLabel = uilabel(app.MovingBarTab);
            app.BarVelocitymmsecEditFieldLabel.HorizontalAlignment = 'right';
            app.BarVelocitymmsecEditFieldLabel.Position = [16 297 122 22];
            app.BarVelocitymmsecEditFieldLabel.Text = 'Bar Velocity (mm/sec)';

            % Create BarVelocitymmsecEditField
            app.BarVelocitymmsecEditField = uieditfield(app.MovingBarTab, 'numeric');
            app.BarVelocitymmsecEditField.ValueChangedFcn = createCallbackFcn(app, @BarVelocitymmsecEditFieldValueChanged, true);
            app.BarVelocitymmsecEditField.Position = [153 297 100 22];
            app.BarVelocitymmsecEditField.Value = 1;

            % Create BarHistory
            app.BarHistory = uitable(app.MovingBarTab);
            app.BarHistory.ColumnName = {'Movement'; 'Bar Angle'; 'Width (mm)'; 'Length (mm)'; 'Color'; 'Repetition'; 'Velocity (mm/s)'};
            app.BarHistory.RowName = {};
            app.BarHistory.Position = [337 17 588 203];

            % Create SaveBarProtocolButton
            app.SaveBarProtocolButton = uibutton(app.MovingBarTab, 'push');
            app.SaveBarProtocolButton.Position = [826 230 100 23];
            app.SaveBarProtocolButton.Text = 'Save Protocol';

            % Create ClearBarHistoryButton
            app.ClearBarHistoryButton = uibutton(app.MovingBarTab, 'push');
            app.ClearBarHistoryButton.Position = [810 270 114 23];
            app.ClearBarHistoryButton.Text = 'Clear Input History';

            % Create LoadBarProtocolButton
            app.LoadBarProtocolButton = uibutton(app.MovingBarTab, 'push');
            app.LoadBarProtocolButton.Position = [718 230 100 23];
            app.LoadBarProtocolButton.Text = 'Load Protocol';

            % Create RecordInputHistoryLabel_3
            app.RecordInputHistoryLabel_3 = uilabel(app.MovingBarTab);
            app.RecordInputHistoryLabel_3.HorizontalAlignment = 'center';
            app.RecordInputHistoryLabel_3.Position = [245 52 114 32];
            app.RecordInputHistoryLabel_3.Text = {'Record Input '; 'History'};

            % Create RecordBarHistorySwitch
            app.RecordBarHistorySwitch = uiswitch(app.MovingBarTab, 'slider');
            app.RecordBarHistorySwitch.Orientation = 'vertical';
            app.RecordBarHistorySwitch.Position = [292 111 20 45];
            app.RecordBarHistorySwitch.Value = 'On';

            % Create ContextMenu
            app.ContextMenu = uicontextmenu(app.UIFigure);

            % Create ApplySettingsMenu
            app.ApplySettingsMenu = uimenu(app.ContextMenu);
            app.ApplySettingsMenu.MenuSelectedFcn = createCallbackFcn(app, @ApplySettingsMenuSelected, true);
            app.ApplySettingsMenu.Text = 'Apply Settings';

            % Create DeleteRowMenu
            app.DeleteRowMenu = uimenu(app.ContextMenu);
            app.DeleteRowMenu.MenuSelectedFcn = createCallbackFcn(app, @DeleteRowMenuSelected, true);
            app.DeleteRowMenu.Text = 'Delete Row';

            % Create AddRowMenu
            app.AddRowMenu = uimenu(app.ContextMenu);
            app.AddRowMenu.Text = 'Add Row';
            
            % Assign app.ContextMenu
            app.FullfieldIlluminationHistory.ContextMenu = app.ContextMenu;

            % Create ContextMenu2
            app.ContextMenu2 = uicontextmenu(app.UIFigure);

            % Create ApplySettingsMenu_2
            app.ApplySettingsMenu_2 = uimenu(app.ContextMenu2);
            app.ApplySettingsMenu_2.MenuSelectedFcn = createCallbackFcn(app, @ApplySettingsMenu_2Selected, true);
            app.ApplySettingsMenu_2.Text = 'Apply Settings';

            % Create DeleteRowMenu_2
            app.DeleteRowMenu_2 = uimenu(app.ContextMenu2);
            app.DeleteRowMenu_2.MenuSelectedFcn = createCallbackFcn(app, @DeleteRowMenu_2Selected, true);
            app.DeleteRowMenu_2.Text = 'Delete Row';

            % Create AddRowMenu_2
            app.AddRowMenu_2 = uimenu(app.ContextMenu2);
            app.AddRowMenu_2.Text = 'Add Row';
            
            % Assign app.ContextMenu2
            app.CheckerboardHistory.ContextMenu = app.ContextMenu2;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LightStim_APP

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end