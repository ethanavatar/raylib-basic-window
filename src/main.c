#include "raylib.h"

const int screenWidth = 800;
const int screenHeight = 600;


void Draw() {
    ClearBackground(RAYWHITE);
    DrawText("Hello, Sailor!", 280, 200, 40, GRAY);
}

int main(void) {

    InitWindow(screenWidth, screenHeight, "Basic Window");
    SetTargetFPS(60);

    while (!WindowShouldClose()) {

        float deltaTime = GetFrameTime();
        float deltaTimeMs = deltaTime * 1000.0f;

        char *title = TextFormat("Basic Window - %.2f ms", deltaTimeMs);
        SetWindowTitle(title);

        BeginDrawing();
            Draw();
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
