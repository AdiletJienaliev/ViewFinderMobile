using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;

public class SceneTransitionTool : Editor
{
    [MenuItem("ChangeScene/Main")]
    public static void MainScene()
    {
        if (EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
        {
            EditorSceneManager.OpenScene("Assets/_InternalAssets/Scenes/SampleScene.unity");
        }
    }
    [MenuItem("ChangeScene/Test")]
    public static void TestScene()
    {
        if (EditorSceneManager.SaveCurrentModifiedScenesIfUserWantsTo())
        {
            EditorSceneManager.OpenScene("Assets/_InternalAssets/Scenes/TestScene.unity");
        }
    }
}
