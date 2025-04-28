#include <cstdlib>
#include <cstring>
#include <string>
#include <algorithm>
#include "../libheif/api/libheif/heif.h"

/*
unsigned char* decode_heic_to_rgba(const std::string& file_path, int* width, int* height, int* channels) {
    heif_context* ctx = heif_context_alloc();

    heif_error err = heif_context_read_from_file(ctx, file_path.c_str(), nullptr);
    if (err.code != heif_error_Ok) {
        heif_context_free(ctx);
        return nullptr;
    }

    heif_image_handle* handle = nullptr;
    err = heif_context_get_primary_image_handle(ctx, &handle);
    if (err.code != heif_error_Ok) {
        heif_context_free(ctx);
        return nullptr;
    }

    heif_image* img = nullptr;
    err = heif_decode_image(handle, &img, heif_colorspace_RGB, heif_chroma_interleaved_RGBA, nullptr);
    if (err.code != heif_error_Ok) {
        heif_image_handle_release(handle);
        heif_context_free(ctx);
        return nullptr;
    }

    int stride;
    const uint8_t* data = heif_image_get_plane_readonly(img, heif_channel_interleaved, &stride);

    *width = heif_image_get_width(img, heif_channel_interleaved);
    *height = heif_image_get_height(img, heif_channel_interleaved);
    *channels = 4;

    size_t buffer_size = (*height) * stride;
    unsigned char* output = (unsigned char*)malloc(buffer_size);
    if (!output) {
        heif_image_release(img);
        heif_image_handle_release(handle);
        heif_context_free(ctx);
        return nullptr;
    }

    memcpy(output, data, buffer_size);

    heif_image_release(img);
    heif_image_handle_release(handle);
    heif_context_free(ctx);

    return output;
}
*/

bool is_heic(const std::string& path) {
    std::string lowercase_path = path;
    std::transform(lowercase_path.begin(), lowercase_path.end(), lowercase_path.begin(), ::tolower);
    return lowercase_path.size() >= 5 && lowercase_path.substr(lowercase_path.size() - 5) == ".heic";
}