import { ReactMediaRecorder } from "react-media-recorder";
import { useState } from "react";
import RecordIcon from "./RecordIcon";

type Props = {
  handleStop: any;
};

const RecordMessage = ({ handleStop }: Props) => {
  const [recording, setRecording] = useState(false);

  const toggleRecording = (start, stop) => {
    if (recording) {
      stop();
    } else {
      start();
    }
    setRecording(!recording);
  };

  return (
     <ReactMediaRecorder
        audio
        onStop={handleStop}
        render={({ status, startRecording, stopRecording }) => (
           <div className="mt-2">
             <button
                onClick={() => toggleRecording(startRecording, stopRecording)}
                className="bg-white p-4 rounded-full"
             >
               <RecordIcon
                  classText={
                    status === "recording"
                       ? "animate-pulse text-red-500"
                       : "text-sky-500"
                  }
               />
             </button>
             <p className="mt-2 text-white font-light">{status}</p>
           </div>
        )}
     />
  );
};

export default RecordMessage;
